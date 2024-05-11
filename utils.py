import functools
import shutil
from typing import Final, Literal, Sequence

import art
from plumbum import cmd, local
from plumbum.machines import LocalCommand

_TERMINAL_WIDTH: Final[int] = shutil.get_terminal_size().columns

_ASCII_FONTS: Final[Sequence[Literal['rectangles', 'standard', 'pepper']]] = (
    'rectangles',
    'standard',
    'pepper',
)


@functools.lru_cache
def install(manager: Literal['dnf', 'apt']) -> LocalCommand:
    return cmd.sudo[
        local[manager],
        'install',
        '-y',
    ]


@functools.lru_cache
def define_font(text: str) -> Literal['rectangles', 'standard', 'pepper', 'tiny']:
    font_index: int = 0

    maybe: str = art.text2art(text, font=_ASCII_FONTS[font_index])

    max_width: int = max(len(line) for line in maybe.split('\n'))

    while max_width > _TERMINAL_WIDTH:
        font_index += 1

        if font_index >= len(_ASCII_FONTS):
            return 'tiny'

        maybe = art.text2art(text, font=_ASCII_FONTS[font_index])
        max_width = max(len(line) for line in maybe.split('\n'))

    return _ASCII_FONTS[font_index]


def ascii_text(text: str) -> str:
    font_family: Literal['rectangles', 'standard', 'pepper', 'tiny'] = define_font(text)  # noqa

    return art.text2art(text, font=font_family)  # type: ignore[no-any-return]
