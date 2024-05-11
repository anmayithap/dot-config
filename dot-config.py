import functools
import platform
from typing import Self

import distro
import tqdm
from plumbum import TF, cli, colors, local
from plumbum.machines import LocalCommand

from constants import CONFIG_DIR, MARK, PACKAGES, SUCCESSFUL_EXIT_CODE
from exceptions import DotConfigExit
from utils import ascii_text, install


class DotConfig(cli.Application):
    DESCRIPTION: str = colors.green | ascii_text('Dot-Config')

    def main(self) -> None:
        print(colors.green | ascii_text('Welcome to Dot-Config'))

        distributive, package_manager = self.distributive_info

        print(
            colors.cyan |
            f'Distributive:     {colors.bold | distributive}\n'
            f'Package manager:  {colors.bold | package_manager}\n\n',
        )

        self.install_packages()
        self.install_pipx()
        self.install_pyenv()
        self.install_goenv()
        self.install_zsh()

    def install_packages(self: Self) -> None:
        print(colors.green | ascii_text('Install Packages'))
        if not local['which'][*PACKAGES] & TF:
            command: LocalCommand = install(self.package_manager)[*PACKAGES]

            self.execute(command, 'Installing packages')
        else:
            print(colors.red | 'No need to install packages')

    def install_pipx(self) -> None:
        print(colors.green | ascii_text('Install PIPX'))

        pipx: LocalCommand = local['pipx']

        command: LocalCommand = pipx['ensurepath'] | pipx['completions']

        self.execute(command, 'Installing pipx')

    def install_pyenv(self) -> None:
        print(colors.green | ascii_text('Install PyEnv'))

        if (path := local.path('~/.pyenv')).exists():
            print(colors.red | f'PyEnv already installing at {path}')
        else:
            curl: LocalCommand = local['curl']
            sh: LocalCommand = local['sh']

            command: LocalCommand = curl['https://pyenv.run'] | sh

            self.execute(command, 'Installing PyEnv')

    def install_goenv(self) -> None:
        print(colors.green | ascii_text('Install GoEnv'))

        if (path := local.path('~/.goenv')).exists():
            print(colors.red | f'GoEnv already installing at {path}')
        else:
            command: LocalCommand = local['git'][
                'clone',
                'https://github.com/go-nv/goenv.git',
                local.path('~/.goenv'),
            ]

            self.execute(command, 'Installing GoEnv')

    def install_zsh(self: Self) -> None:
        print(colors.green | ascii_text('Install ZSH'))

        print(colors.red | 'Change shell to zsh')

        path_to_zsh: str = local['which']('zsh').strip()

        local['chsh']('-s', path_to_zsh)

        print(colors.red | 'Shell successfully changed')

        if (path := local.path('~/.zshrc')).exists():
            if local['grep']['-q', MARK, path] & TF:
                while True:
                    match input(colors.yellow | '.zshrc already installed, re-install? [Y/n]: ').lower():
                        case 'y' | 'yes' | 'yep':
                            print(
                                colors.red |
                                'Backup old .zshrc file as ".zshrc.backup"',
                            )
                            local['mv'](path, local.path('~/.zshrc.backup'))
                            break
                        case 'n' | 'no' | 'nope':
                            print(colors.red | 'Exit...')
                            exit(SUCCESSFUL_EXIT_CODE)
                        case _:
                            print(colors.red | 'Please answer `Y` or `N`')

        print(colors.red | '.zshrc not installed. Installing...')

        local['cp'](CONFIG_DIR / '.zshrc', path)

        (local['echo'][f'# {MARK}'] >> path)()

        local['mkdir']('-p', local.path('~/.zsh'))

        for file in CONFIG_DIR.glob('*.zsh'):
            local['cp'](file, local.path('~/.zsh'))

    def execute(self: Self, command: LocalCommand, description: str) -> None:
        progress_bar: tqdm.tqdm = self.get_progress_bar(
            colors.red | description,
        )

        with command.popen() as process:
            for line in iter(process.stdout.readline, b''):
                progress_bar.update(len(line))
            process.wait()

        progress_bar.close()

    @staticmethod
    def get_progress_bar(description: str) -> tqdm.tqdm:
        return tqdm.tqdm(
            total=100,
            desc=description,
            unit="B",
            unit_scale=True,
        )

    @functools.cached_property
    def distributive_info(self: Self) -> tuple[str, str]:
        if (uname := platform.system()) != 'Linux':
            print(f'Not supported OS: {uname}')
            raise DotConfigExit

        match distributive := distro.id().lower():
            case "fedora" | "centos":
                package_manager: str = "dnf"
            case "ubuntu" | "debian":
                package_manager = "apt"
            case _:
                print(f'Unknown distributive "{distributive}" to find package manager.')  # noqa
                raise DotConfigExit

        self._package_manager: str = package_manager

        return distributive, package_manager

    @property
    def package_manager(self: Self) -> str:
        return self._package_manager


if __name__ == '__main__':
    application = DotConfig()
    application.run()
