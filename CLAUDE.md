# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Homebrew tap repository that provides backports of older ASDF versions before the switch to Golang. The main purpose is to maintain access to ASDF v0.11.2 for systems that need the older shell-based implementation.

## Key Files Structure

- `Formula/asdf@0.11.2.rb` - Homebrew formula for ASDF v0.11.2 installation
- `test_dotfiles.py` - Integration test that validates ASDF installation and functionality using tmux sessions
- `Makefile` - Contains test commands for running the test suite

## Development Commands

### Testing
```bash
# Run full test suite with retries
make test

# Run tests with debugger on failure
make test-pdb

# Direct pytest execution
py.test --tb=short --no-header --showlocals --reruns 6 test_dotfiles.py
```

## Test Architecture

The test suite uses a tmux-based testing approach:
- Tests run in isolated tmux sessions to simulate real shell environments
- `conftest.py` provides fixtures for tmux server and session management
- Tests verify ASDF version matches the formula specification (v0.11.2)
- Tests are skipped in CI (GITHUB_ACTOR environment) and designed for local development

## Formula Details

The ASDF formula (`Formula/asdf@0.11.2.rb`):
- Installs ASDF v0.11.2 from GitHub archive
- Includes shell completions for bash, fish, and zsh
- Disables update functionality by creating `asdf_updates_disabled` file
- Provides installation caveats for shell profile setup

## Dependencies

Python testing dependencies are managed in `requirements-test.txt` and include:
- pytest with various plugins (rerunfailures, sugar, cov)
- libtmux for tmux session management
- Development tools (bpython, ptpython)
