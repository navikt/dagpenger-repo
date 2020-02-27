SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

sync: meta-update copy-files
.PHONY: sync

clean:
	rm -rf node_modules
	rm -rf tmp
.PHONY: clean

tmp/.has-nvm.sentinel:
	[ -s "/usr/local/opt/nvm/nvm.sh" ] || brew install nvm
	mkdir -p $(@D) && touch $@

tmp/.nvm-set.sentinel: .nvmrc tmp/.has-nvm.sentinel
	nvm install && nvm use
	mkdir -p $(@D) && touch $@

tmp/.meta-installed.sentinel: tmp/.nvm-set.sentinel
	npm install meta --no-save
	mkdir -p $(@D) && touch $@

meta-update: .nvmrc .meta tmp/.meta-installed.sentinel
	meta git update

# Files to be kept in sync with template
CODEOWNERS := $(shell ls */CODEOWNERS)
$(CODEOWNERS): .service-template/CODEOWNERS
	cp $< $@

LICENSES := $(shell ls */LICENSE.md)
$(LICENSES): .service-template/LICENSE.md
	cp $< $@

CONSTANTS := $(shell ls */buildSrc/src/main/kotlin/Constants.kt)
$(CONSTANTS): .service-template/buildSrc/src/main/kotlin/Constants.kt

copy-files: $(CODEOWNERS) $(LICENSES) $(CONSTANTS)
