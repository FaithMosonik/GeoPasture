# GeoPasture

A livestock management system for pastoral communities in Kenya.

## Overview
GeoPasture combines satellite-based pasture analysis, wearable sensor 
behaviour classification, and an offline-first mobile architecture to 
help pastoralists make informed herd and grazing decisions.

## Modules
- **Behaviour Module** — CNN+LSTM model for cow behaviour classification 
  and distress alerting (Faith)
- **Pasture Module** — Satellite-based biomass and carrying capacity 
  estimation using Sentinel-2 and MODIS (Moses)
- **Offline Architecture** — TFLite on-device inference, SQLite local 
  storage, and Firebase sync (Lynn)

## Tech Stack
- Flutter (mobile app)
- TensorFlow Lite (on-device behaviour inference)
- SQLite via sqflite (local storage)
- Firebase Firestore and Authentication (cloud backend)
- Firebase Storage (pasture map tiles)
- Google Earth Engine (satellite imagery processing)

## Branch Strategy
- `main` — stable releases only, requires pull request and 1 approval
- `dev` — integration branch, all features merge here first
- `feature/behaviour-module` — Faith's branch
- `feature/offline-architecture` — Lynn's branch
- `feature/pasture-module` — Moses' branch

## Setup Instructions

### Prerequisites
- Flutter SDK 3.x
- Android Studio with an emulator or physical Android device
- Firebase project access

### Getting Started
1. Clone the repository
   git clone https://github.com/FaithMosonik/GeoPasture.git
2. Request the google-services.json file from Faith and place it at:
   android/app/google-services.json
3. Install dependencies
   flutter pub get
4. Run the app
   flutter run

## Database Schema
The app uses SQLite for local storage with the following tables:
PASTORALIST, HERD, ANIMAL, WEARABLE, ACCELEROMETER_READING,
BEHAVIOUR_CLASSIFICATION, DISTRESS_ALERT, PASTURE_MAP, 
GRAZING_SESSION, SYNC_LOG

Full schema is documented in /docs/schema.sql

## Data Contracts
- behaviour_class stored as INTEGER: 0=Feeding, 1=Rumination, 
  2=Standing, 3=Lying, 4=Walking
- confidence stored as REAL: softmax probability 0.0 to 1.0
- Alert thresholds: Feeding <5%, Rumination <3%, Walking >85%

## Model Information
- Architecture: 1D CNN + LSTM
- Input shape: (100, 3) — 100 timesteps, 3 accelerometer axes
- Preprocessing: 6th-order Butterworth high-pass filter at 0.3Hz
- Classes: 5 behaviours
- Validation accuracy: 89.89%
- Test accuracy on unseen animal: 87.98%
