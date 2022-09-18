default: help

.PHONY: fetch ## Fetches the nocodb dump from GCS.
gsutil rsync -r gs://random.mccurdyc.dev/nocodb .

.PHONY: run ## Runs the nocodb docker container.
docker run -d --name nocodb \
-v "$(pwd)"/nocodb:/usr/app/data/ \
-p 8080:8080 \
nocodb/nocodb:latest

.PHONY: dump ## Writes the nocodb db to GCS.
gsutil rsync -d -r nocodb gs://random.mccurdyc.dev/nocodb

.PHONY: help
help: ## Prints this help menu.
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
