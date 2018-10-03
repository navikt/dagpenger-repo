# Dagpenger

En samling mikrotjenester for å behandle Dagpenger.

# Komme i gang

[repo](https://source.android.com/setup/develop/repo) brukes til å sette opp
repositories for alle microservicene. Det kan [innstalleres
manuelt](https://source.android.com/setup/build/downloading) eller via homebrew

`brew install repo`

Repositoriene settes opp med:

```
repo init -u git@github.com:navikt/dagpenger.git
repo sync
repo start master
```

Nå kan git brukes som normalt for hvert repo.

## Bygg

Gradle brukes som byggverktøy og er bundlet inn. Composite build brukes for
å unngå å bygge nye versjoner av fellesbibliotekene på nytt hver gang, men løses
automatisk av Gradle.

`./gradlew build`

---

# Henvendelser

Spørsmål knyttet til koden eller prosjektet kan rettes mot:

* André Roaldseth, andre.roaldseth@nav.no
* Eller en annen måte for omverden å kontakte teamet på

## For NAV-ansatte

Interne henvendelser kan sendes via Slack i kanalen #dagpenger.

# HOWTO 

## Teste lokalt
I prosjektet finnes det en docke-compose.yml - kjør opp denne med `docker-compose up`
I dagpenger-joark-mottak katalogen finnes det en `DummyJoarkProducer` som en kan starte opp for å simulere journalpost hendelser - start deretter `JoarkMottak` i dagpenger-joark-mottak for å starte første ledd i innløpet. 
