default: help

.PHONY: fetch ## Fetches the nocodb dump from GCS.
fetch:
	@gsutil rsync -r gs://random.mccurdyc.dev/nocodb nocodb/

.PHONY: run ## Runs the nocodb docker container.
run:
	@docker run --rm -d --name nocodb \
		-v "$(shell pwd)"/nocodb:/usr/app/data/ \
		-p 8080:8080 \
		nocodb/nocodb:0.104.3

.PHONY: dump ## Writes the nocodb db to GCS.
dump:
	@gsutil rsync -d -r nocodb gs://random.mccurdyc.dev/nocodb

.PHONY: help
help: ## Prints this help menu.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
