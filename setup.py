#!/usr/bin/env python3

import argparse
import os
import shutil
import json

def create_directory(target_path, mode, debug=False):
    """
    Creates a directory at the specified target path with the given mode (permissions).

    Args:
        target_path (str): The path where the directory should be created.
        mode (str): The permissions mode (e.g., "0700") for the new directory.
        debug (bool, optional): If True, print debug information. Defaults to False.

    Raises:
        Exception: If the directory creation fails.
    """
    try:
        if debug:
            print(f"Creating directory: {target_path}")
        if not os.path.exists(target_path):
            os.makedirs(target_path, mode=int(mode, 8))
            print(f"Created directory: {target_path}")
        else:
            print(f"Directory already exists: {target_path}")
    except Exception as e:
        print(f"Failed to create directory {target_path}: {e}")

def create_link(source_path, target_path, force, debug=False):
    """
    Creates a symbolic link from source_path to target_path. If force is True and the target exists, it will be removed.

    Args:
        source_path (str): The source file or directory to link.
        target_path (str): The path where the symbolic link should be created.
        force (bool): If True, overwrite the existing symbolic link or file.
        debug (bool, optional): If True, print debug information. Defaults to False.

    Raises:
        Exception: If the symbolic link creation fails.
    """
    try:
        if debug:
            print(f"Creating symlink: {source_path} -> {target_path}")
        if os.path.exists(target_path) and force:
            os.unlink(target_path)
            print(f"Removed existing symlink: {target_path}")
        if not os.path.exists(target_path):
            absolute_source_path = os.path.abspath(source_path)
            os.symlink(absolute_source_path, target_path)
            print(f"Created symlink: {target_path} -> {absolute_source_path}")
        else:
            print(f"Symlink already exists: {target_path}")
    except Exception as e:
        print(f"Failed to create symlink {target_path}: {e}")

def create_copy(source_path, target_path, force, debug=False):
    """
    Copies a file from source_path to target_path. If force is True and the target exists, it will be renamed.

    Args:
        source_path (str): The source file to be copied.
        target_path (str): The path where the file should be copied.
        force (bool): If True, rename the existing file before copying.
        debug (bool, optional): If True, print debug information. Defaults to False.

    Raises:
        Exception: If the file copy fails.
    """
    try:
        if debug:
            print(f"Copying file: {source_path} -> {target_path}")
        if os.path.exists(target_path) and force:
            os.rename(target_path, target_path + ".orig")
            print(f"Renamed existing file: {target_path} -> {target_path}.orig")
        if not os.path.exists(target_path):
            shutil.copy(source_path, target_path)
            print(f"Copied file: {source_path} -> {target_path}")
        else:
            print(f"File already exists: {target_path}")
    except Exception as e:
        print(f"Failed to copy file from {source_path} to {target_path}: {e}")

def process_files(files, force=False, override_home=None, debug=False):
    """
    Processes a list of file operations (create directory, create link, copy file) based on the provided manifest.

    Args:
        files (list): A list of file operation dictionaries, each containing the keys 'type', 'source', 'target', and 'mode'.
        force (bool, optional): If True, forces overwrite of existing files. Defaults to False.
        override_home (str, optional): If provided, overrides the home directory for the target paths. Defaults to None.
        debug (bool, optional): If True, print debug information. Defaults to False.
    """
    base_home = override_home if override_home else os.path.expanduser("~")

    for file in files:
        # Construct the target path using the base home directory
        target_path = os.path.join(base_home, file["target"])

        if file["type"] == "directory":
            create_directory(target_path, file.get("mode", "0700"), debug=debug)
        elif file["type"] == "link":
            create_link(file["source"], target_path, force=force, debug=debug)
        elif file["type"] == "copy":
            create_copy(file["source"], target_path, force=force, debug=debug)
        else:
            print(f"Unknown file type: {file['type']}")

def main():
    """
    Main function that handles argument parsing and initiates file processing.

    Command-line Arguments:
        -f/--file: Path to the manifest file (default: 'manifest.json').
        -F/--force: Force overwrite of existing files.
        -O/--override-home: Override the user's home directory with a different path.
        -d/--debug: Enable debug mode for verbose output.

    The manifest file should be a JSON file containing a "files" key with a list of file operations.
    Each file operation should include:
        - "type": The type of operation ("directory", "link", "copy").
        - "source": The source path (for "link" and "copy" operations).
        - "target": The target path where the file or directory should be created.
        - "mode": (Optional) The permissions mode for directories (default: "0700").
    """
    parser = argparse.ArgumentParser(description="Process files according to a manifest JSON file.")
    parser.add_argument("-f", "--file", help="Path to the manifest file (JSON)", default="manifest.json")
    parser.add_argument("-F", "--force", action="store_true", help="Force overwrite existing files")
    parser.add_argument("-O", "--override-home", help="Override the user's home directory with a different path")
    parser.add_argument("-d", "--debug", action="store_true", help="Enable debug mode with extra output")
    args = parser.parse_args()

    manifest_file = args.file

    if not os.path.exists(manifest_file):
        print(f"Error: Manifest file '{manifest_file}' not found.")
        return

    if args.force:
        print("Force mode enabled: existing files will be renamed.")

    with open(manifest_file, "r") as f:
        try:
            data = json.load(f)
        except json.JSONDecodeError as e:
            print(f"Error: Failed to parse JSON file '{manifest_file}': {e}")
            return

        if "files" in data:
            process_files(data["files"], force=args.force, override_home=args.override_home, debug=args.debug)
        else:
            print("No 'files' key found in data.")

if __name__ == "__main__":
    main()
