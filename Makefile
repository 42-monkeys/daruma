deploy:
	ssh -A baldarn@cervellone.lan "cd projects/daruma; git pull; exit"
	ssh baldarn@cervellone.lan "docker exec daruma rails db:migrate; exit"
	ssh baldarn@cervellone.lan "cd projects/daruma; docker compose down; docker compose up -d; exit"
