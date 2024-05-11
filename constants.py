import pathlib
from typing import Final, Iterable

PROJECT_DIR: Final[pathlib.Path] = pathlib.Path(__file__).resolve().parent
CONFIG_DIR: Final[pathlib.Path] = PROJECT_DIR / 'config'

MARK: Final[str] = 'ANMAYITHAP. ZSHRC'
PACKAGES: Final[Iterable[str]] = (
    'vim',
    'zsh',
    'lsd',
    'pipx',
    'flatpak',
)

SUCCESSFUL_EXIT_CODE: Final[int] = 0
ERROR_EXIT_CODE: Final[int] = 1
