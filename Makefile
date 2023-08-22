default: help

.PHONY: fetch ## Fetches the nocodb dump from GCS.
fetch:
	if [ ! -d "nocodb/" ]; then \
		mkdir -p $(CURDIR)/nocodb; \
	fi
	@gsutil rsync -r gs://random.mccurdyc.dev/nocodb/ $(CURDIR)/nocodb/

.PHONY: run ## Runs the nocodb docker container.
run:
	@docker run --rm -d --name nocodb \
		-v "$(CURDIR)/nocodb:/usr/app/data/" \
		-p 0.0.0.0:8080:8080 \
		nocodb/nocodb:0.109.7

.PHONY: dump ## Writes the nocodb db to GCS.
dump:
	@gsutil rsync -d -r nocodb/ gs://random.mccurdyc.dev/nocodb

.PHONY: help
help: ## Prints this help menu.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
