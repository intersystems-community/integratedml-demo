# IntegratedML Demo Kit

This repo contains a few simple datasets to demonstrate InterSystems IRIS IntegratedML (previously known as QuickML). Instructions below describe how to use IntegratedML on Docker, Linux/Mac or Windows platforms.

**Note**: *If you are an InterSystems employee, and want to use another docker image, see the section [Using a different docker image](#using-a-different-docker-image)*

## How to install/build on Docker

The included Dockerfile will pull an InterSystems IRIS Advanced Analytics Community Edition image the InterSystems Developer Community Docker repository and set up a few simple datasets. Use the following command to start building:

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

### Using a different docker image

If you are an InterSystems employee and would like to use a different docker image, one that requires a valid InterSystems license key, you can edit the Dockerfile to change the image, and copy the license key file into the the image. If you are going to use a docker image from our internal Docker repository, see [here](https://usconfluence.iscinternal.com/display/RE/Quay+Docker+Repository+Access) if you haven't used docker.iscinternal.com before.

:warning: For minimal security reasons, **an IRIS key is not included in this repo**, and this will be your one manual step in order 
to be able to build an image. Save the IRIS key provided to you as ```iris.ISCkey``` in the root folder of your local download of 
this repo (so next to README.md and Dockerfile). Then use the following command to start building

## How to use IntegratedML

Using IntegratedML takes only three simple commands:

```sql
CREATE MODEL Flowers PREDICTING (Species) FROM DataMining.IrisDataset;
TRAIN MODEL Flowers FROM DataMining.IrisDataset;
SELECT TOP 20 PREDICT(Flowers) AS PredictedSpecies, Species AS ActualSpecies FROM DataMining.IrisDataset;
```

Note that the semicolons at the end are for use in a multiline-style client such as DBeaver or SQuirreL and not part of regular IRIS SQL.

### More Resources

- [IntegratedML User Guide](https://docs.intersystems.com/iris20202/csp/docbook/DocBook.UI.Page.cls?KEY=GIML)
- [Learn IntegratedML from InterSystems Learning Services](https://learning.intersystems.com/course/view.php?id=1346)

### Included datasets

These are broadly available datasets, but we may not have permission to _re_-distribute them, so keep this repo to yourself:
- DataMining.IrisDataset: Iris (the flower, not the Gartner MQ ODBMS leader!), as in the classic SAMPLES namespace. You can predict the Species (categorization) or any of the width / length columns (regression)
- Titanic.Passenger: List of all the passengers of the ill-fated bathtub, with a "Survived" column that makes a fun demo targejt.
- \[SQLUser.\]LoanPerformance: as used at Global Summit, with a "LoanDefault" column that works well for a more serious demo. Derived from a [Kaggle dataset](https://www.kaggle.com/avikpaul4u/vehicle-loan-default-prediction)
- \[SQLUser.\]Campaign: as used in the campaign showcase in the [ML Toolkit](https://github.com/intersystems/MLToolkit). The target column to put your crosshairs on is RESPONSE
- \[SQLUser.\]BreastCancer
- \[SQLUser.\]appointments
