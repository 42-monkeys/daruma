[![Hippocratic License HL3-FULL](https://img.shields.io/static/v1?label=Hippocratic%20License&message=HL3-FULL&labelColor=5e2751&color=bc8c3d)](https://firstdonoharm.dev/version/3/0/full.html)

# Daruma

A simple app to add your resolutions and help you stick with those!

The idea comes from the will of helping to stick with the chosen resolutions.

# How it works

You can chose some things when making a resolution:

- resolution
- temper of the daruma
- commitment
- time limit for the resolution
- offer

### Resolution

A simple text that identifies your resolution (e.g: I want to pass the math exam).

### Temper

This selects how Daruma will help you. The messages that will arrives will be modulated based on the chosen temper. If random is selected, it will change every time ;)

### Commitment

This will change the interval of messages received, from low to high

### Time limit

This is the time limit for your resolution

### Offer

The offer is optional.

Making an offer enhance your motivation to get your resolution done.

Daruma will keep the offer with him and give that back if the resolution succeded.

The success of the resolution is self declared, of course ;)

# Business model

If people make offers, this amounts of money will be used to trade with NO risk (but low income of course)

# Development

* use hooks
```bash
git config --local include.path ../.gitconfig
```

* develop with docker

```bash
docker-compose up -d
```

* To launch the rails shell

```bash
docker exec -it daruma rails c
```

* To debug

After `docker-compose up -d`
```bash
docker attach daruma
```

* To test

After `docker-compose up -d`
```bash
docker exec -it daruma rails test
```
