# -----------------------------------------------------------------------------
# Liblarch - a library to handle directed acyclic graphs
# Copyright (c) 2011-2012 - Lionel Dricot & Izidor Matušov
#
# This program is free software: you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option) any
# later version.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.
# -----------------------------------------------------------------------------

# Simple makefile for common tasks
check: tests lint

tests:
	./run-tests

sdist:
	python setup.py sdist

# Remove .pyc files
clean:
	find -type d -name '__pycache__' -print | xargs rm -rf
	find -type f -iname '*.~*~' -exec rm {} \;
	rm -f *.bak
	rm -rf dist/

# Check for common & easily catchable Python mistakes.
pyflakes:
	pyflakes examples liblarch liblarch_gtk tests \
	main.py run-tests setup.py

# Check for coding standard violations.
pep8:
	pycodestyle --statistics --count --repeat --max-line-length=110 --ignore=E128,W504 \
	examples liblarch liblarch_gtk tests main.py run-tests setup.py

# Check for coding standard violations & flakes.
lint: pyflakes pycodestyle

.PHONY: check tests sdist clean pyflakes pycodestyle lint
