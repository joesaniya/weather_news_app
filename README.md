# Weather and News Aggregator App

This Flutter app fetches weather data and displays news headlines based on the current weather conditions. It implements a unique feature of filtering news based on the weather—cold weather shows depressing news, hot weather shows fear-related news, and cool weather shows happy/winning news. The app allows users to customize their experience by selecting their preferred temperature units and news categories.

## Features

- **Weather Information:**
  - Displays current weather data, including temperature, weather conditions, and a 5-day forecast.
  - Allows users to switch between Celsius and Fahrenheit.

- **News Headlines:**
  - Fetches the latest news headlines and displays them with brief descriptions and links to full articles.
  - Filters news based on the current weather:
    - **Cold weather**: Shows depressing news.
    - **Hot weather**: Shows fear-related news.
    - **Cool weather**: Shows happy/winning news.

- **Settings:**
  - Users can toggle between Celsius and Fahrenheit for temperature units.
  - Users can select preferred news categories (e.g., Technology, Business, Sports).

## Project Structure

weather-news-aggregator-app/
├── lib/
│   ├── main.dart                  # Entry point of the app
│   ├── models/                    # Data models for Weather and News
│   ├── providers/                 # Provider classes to manage app state
│   ├── screens/                   # Screens for displaying weather and news
│   ├── services/                  # API services for fetching data
│   └── utils/                     # Utility functions (e.g., weather-based filtering)
├── assets/                        # Assets like images, icons, etc.
├── pubspec.yaml                   # Project dependencies and metadata
├── README.md                      # Project documentation



## Technologies Used

- **Framework**: Flutter
- **State Management**: Provider
- **UI Design**: Material Design

## API Integrations

This app uses the following publicly available APIs:

1. **OpenWeatherMap API** – For fetching weather data.
   - API Key required. You can sign up for a free API key [here](https://openweathermap.org/).

2. **NewsAPI** – For fetching the latest news headlines.
   - API Key required. You can sign up for a free API key [here](https://newsapi.org/).

## Prerequisites

- **Flutter**: 2.8.0 or later
- **Dart**: 2.14 or later
- An API key for both OpenWeatherMap and NewsAPI.

## Setup Instructions

Follow these steps to set up the project locally.

### 1. Clone the Repository

Clone the repository to your local machine:

```bash
git clone https://github.com/joesaniya/weather_news_app
