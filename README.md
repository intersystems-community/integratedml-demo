# IntegratedML Demo Kit

This repo contains a few simple datasets to demonstrate InterSystems IRIS IntegratedML. Instructions below describe how to use IntegratedML on Docker, Linux/Mac or Windows platforms.

## How to install/build on Docker

The included Dockerfile will pull an InterSystems IRIS IntegratedML Community Edition image from the Docker Hub and set up a few simple datasets. Full Enterprise Edition container images are available from the [InterSystems Container Repository](https://docs.intersystems.com/components/csp/docbook/Doc.View.cls?KEY=PAGE_containerregistry). 

Use the following command to build the demo image:

```
docker build --tag integratedml-demo .
```

To start your container, use the following command (or your favourite equivalent, as this one will drop your container after stopping)

```
docker run --rm -d -p 9091:1972 -p 9092:52773 --name integratedml integratedml-demo
```

The IRIS password is initialized as SYS, but you can get in directly through the following command, the SMP or connecting through a SQL client such as [DBeaver](https://dbeaver.io/)

```
docker exec -it integratedml iris sql IRIS
```

## How to use IntegratedML

Using IntegratedML takes only three simple commands:

```sql
CREATE MODEL Flowers PREDICTING (Species) FROM DataMining.IrisDataset;
TRAIN MODEL Flowers FROM DataMining.IrisDataset;
SELECT TOP 20 PREDICT(Flowers) AS PredictedSpecies, Species AS ActualSpecies FROM DataMining.IrisDataset;
```

Note that the semicolons at the end are for use in a multiline-style client such as DBeaver or SQuirreL and not part of regular IRIS SQL.

### More Resources

- [IntegratedML User Guide](https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=GIML)
- [Learn IntegratedML from InterSystems Learning Services](https://learning.intersystems.com/course/view.php?id=1346)

### Included datasets

These are broadly available datasets, but we may not have permission to _re_-distribute them, so keep this repo to yourself:
- DataMining.IrisDataset: Iris (the flower, not the Gartner MQ ODBMS leader!), as in the classic SAMPLES namespace. You can predict the Species (categorization) or any of the width / length columns (regression)
- Titanic.Passenger: List of all the passengers of the ill-fated bathtub, with a "Survived" column that makes a fun demo target.
- \[SQLUser.\]LoanPerformance: as used at Global Summit, with a "LoanDefault" column that works well for a more serious demo. Derived from a [Kaggle dataset](https://www.kaggle.com/avikpaul4u/vehicle-loan-default-prediction)
- \[SQLUser.\]Campaign: as used in the campaign showcase in the [ML Toolkit](https://github.com/intersystems/MLToolkit). The target column to put your crosshairs on is RESPONSE
- \[SQLUser.\]BreastCancer
- \[SQLUser.\]appointments
- NLP.HateSpeech - anticipating some work on the NLP end, taking a text classification challenge from https://github.com/aitor-garcia-p/hate-speech-dataset
