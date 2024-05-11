from constants import ERROR_EXIT_CODE


class DotConfigExit(SystemExit):
    code: int = ERROR_EXIT_CODE
