# Build the project
build:
	yarn install
	yarn build

# Run tests
test: build
	yarn test

# Create an npm tarball (equivalent to a Python wheel)
pack: build
	npm pack

# Run the codemod locally using the built plugin against a target directory
# Usage: just run-local ../my-project/src
run-local target_dir: build
	npx @codemod/cli --plugin ./dist/index.js '{{target_dir}}/**/*.tsx' '{{target_dir}}/**/*.ts' '{{target_dir}}/**/*.jsx' '{{target_dir}}/**/*.js'

# Run the codemod using the packaged tarball against a target directory
# Usage: just run-tarball ../my-project/src
run-tarball target_dir: pack
	@echo "Running via tarball..."
	npx @codemod/cli --plugin ./react-declassify-0.2.0.tgz '{{target_dir}}/**/*.tsx' '{{target_dir}}/**/*.ts' '{{target_dir}}/**/*.jsx' '{{target_dir}}/**/*.js'

# Run the Codemod AI Workflow (runs the codemod + AI review)
run-workflow target_dir: build
	npx codemod@latest run . --target {{target_dir}}
