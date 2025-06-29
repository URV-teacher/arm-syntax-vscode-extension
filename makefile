# Variables
EXTENSION_NAME := arm-syntax-vscode-extension
VSIX_FILE := $(EXTENSION_NAME).vsix

# Default target
.PHONY: all
all: $(VSIX_FILE)


# Build the VSCode extension (only if VSIX does not exist)
$(VSIX_FILE): package.json CHANGELOG.md extension.js language-configuration.json LICENSE README.md images/logo.png syntaxes/arm.tmLanguage.json
	@echo "🔨 Building the VSCode extension..."
	@npm install
	@vsce package --out $(VSIX_FILE)
	@echo "✅ Build complete: $(VSIX_FILE)"

## Install the VSCode extension
.PHONY: install
install: $(VSIX_FILE)
	@echo "🚀 Installing the VSCode extension..."
	@code --install-extension $(VSIX_FILE) --force
	@echo "✅ Extension installed."

## Uninstall the VSCode extension
.PHONY: uninstall
uninstall: $(VSIX_FILE)
	@echo "🗑️ Uninstalling the VSCode extension..."
	@code --uninstall-extension $(VSIX_FILE)
	@echo "✅ Extension uninstalled."

## Clean generated files
.PHONY: clean
clean:
	@echo "🧹 Cleaning build artifacts..."
	@rm -f $(VSIX_FILE)
	@echo "✅ Clean complete."
