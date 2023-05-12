deploy:
	ssh -A baldarn@cervellone.lan:projects/daruma "git pull; exit"
	ssh baldarn@cervellone.lan:projects/daruma "docker compose down; exit"
	ssh baldarn@cervellone.lan:projects/daruma "docker compose --env-file .env.production up --build -d; exit"
	ssh baldarn@cervellone.lan:projects/daruma "docker exec daruma whenever --update-crontab; exit"

dev:
	docker compose up -d --build
	docker image prune -f
