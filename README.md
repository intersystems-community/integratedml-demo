# IntegratedML Demo Kit

This repo contains a few simple datasets to demonstrate InterSystems IRIS IntegratedML (previously known as QuickML). Instructions below describe how to use IntegratedML on Docker, Linux/Mac or Windows platforms.

**Note**: *If you are an InterSystems employee, you will use a different github repository, for which you will need to email thomas.dyar@intersystems.com for access*

## How to install/build on Docker

The included Dockerfile is configured to pull an InterSystems IRIS docker image that contains IntegratedML. The first step will be to download the docker image from the ftp server, according to instructions in an email that you will receive during onboarding into the IntegratedML beta program. Once you have the image file you will register it on your local machine with the following command:

```
docker  load < integratedml_beta_0.3.tar.gz
```

The included Dockerfile will use that container image just loaded, inject a license and set up a few simple datasets.

:warning: For minimal security reasons, **an IRIS key is not included in this repo**, and this will be your one manual step in order to be able to build an image. Save the IRIS key provided to you as ```iris.key``` in the root folder of your local download of this repo (so next to README.md and Dockerfile). Then use the following command to start building

```
docker build --tag integratedml-demo .
```

To start your container, use the following command (or your favourite equivalent, as this one will drop your container after stopping)

```
docker run --rm -d -p 9091:51773 -p 9092:52773 --name integratedml integratedml-demo
```

The IRIS password is initialized as SYS, but you can get in directly through the following command, the SMP or connecting through a SQL client such as [DBeaver](https://dbeaver.io/)

```
docker exec -it integratedml iris sql IRIS
```

## How to install datasets on Linux / Mac

First, install IRIS using the kit installer and license key provided to you as part of the IntegratedML beta program. These instructions will presume you have named the IRIS instance "IRIS", and the directory where IRIS is installed is <IRIS_INSTALL_DIR>. Then from a terminal at the root folder of your local download of this repo (so next to README.md and Dockerfile), run these commands to set the license key and copy the data into IRIS:

```
iris start IRIS && iris session IRIS < iris.script
```

## How to install datasets on Windows

First, install IRIS using the kit and license key provided to you as part of the IntegratedML beta program. Running IntegratedML on Windows is a bit limited in functionality, and is best discussed with InterSystems Product Management to determine how best to proceed.


## How to use IntegratedML

Using IntegratedML takes only three simple commands:

```sql
CREATE MODEL Flowers PREDICTING (Species) FROM DataMining.IrisDataset;
TRAIN MODEL Flowers FROM DataMining.IrisDataset;
SELECT TOP 20 PREDICT(Flowers) AS PredictedSpecies, Species AS ActualSpecies FROM DataMining.IrisDataset;
```

Note that the semicolons at the end are for use in a multiline-style client such as DBeaver or SQuirreL and not part of regular IRIS SQL. See the [IntegratedML Syntax overview](https://github.com/tom-dyar/integratedml-demo/doc/IntegratedMLSyntax.pdf) if you want to be more creative. For example, you can add ```USING { "provider": "H2O" }``` to your CREATE or TRAIN commands to test the H2O provider instead of the default one.

### Included datasets

These are broadly available datasets, but we may not have permission to _re_-distribute them, so keep this repo to yourself:
- DataMining.IrisDataset: Iris (the flower, not the Gartner MQ ODBMS leader!), as in the classic SAMPLES namespace. You can predict the Species (categorization) or any of the width / length columns (regression)
- Titanic.Passenger: List of all the passengers of the ill-fated bathtub, with a "Survived" column that makes a fun demo target.
- \[SQLUser.\]LoanPerformance: as used at Global Summit, with a "LoanDefault" column that works well for a more serious demo. Derived from a [Kaggle dataset](https://www.kaggle.com/avikpaul4u/vehicle-loan-default-prediction)
- \[SQLUser.\]Campaign: as used in the campaign showcase in the [ML Toolkit](https://github.com/intersystems/MLToolkit). The target column to put your crosshairs on is RESPONSE
- \[SQLUser.\]BreastCancer
- \[SQLUser.\]appointments
