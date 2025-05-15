"""
Simple script to get needed system dependencies for this neovim config to work.
"""

import sys
import argparse
import shutil


def main(package_manager: str) -> int:
    """
    Main driver to install system dependencies

    :param package_manager: system package manager to use. Must be on PATH.
    """

    package_manager_path: str | None = shutil.which(package_manager)

    if package_manager_path is None:
        print(f"{package_manager} does not seem to be on the system PATH...",
              file=sys.stderr)
        return -1

    return 0


if __name__ == "__main__":
    parser: argparse.ArgumentParser = argparse.ArgumentParser()
    parser.description = __doc__

    parser.add_argument("-p",
                        "--pacman",
                        required=True,
                        type=str,
                        help="System package manager to use")

    parser.add_argument("-i",
                        "--install",
                        required=False,
                        type=str,
                        help="Command to pass to the package manager to "
                             "install a package. For example, '-i install' "
                             "on a Debian system with '-p apt' will cause "
                             "this script to invoke 'apt install' when "
                             "installing packages")

    args: argparse.Namespace = parser.parse_args()

    result: int = main(args.pacman)
    sys.exit(result)
