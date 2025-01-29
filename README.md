# Weather App

A simple Rails web application that allows users to enter a location and view the 7-day weather forecast, including high and low temperatures for each day. The app fetches weather data using an external API and provides users with an easy-to-read forecast for their chosen location.

## Features

- **Add a Location**: Users can enter a location (e.g., city name) to fetch weather data.
- **7-Day Forecast**: Displays a 7-day weather forecast for the entered location, showing high and low temperatures.
- **Chart Visualization**: Visualizes the highs and lows of the forecast using a chart.

## Technologies Used

- **Ruby on Rails**: A full-stack web framework for developing the app.
- **HTTParty**: To make API calls to external weather services and geolocation services.
- **JavaScript (Chart.js)**: For creating charts to display the weather data visually.

## Setup and Installation

### Prerequisites

- Ruby 3.x+
- Rails 6.x+
- Bundler (gem for managing dependencies)
- Git (to clone the repository)

### Steps to Get the App Running Locally

1. **Clone the repository**:
   First, clone this repository to your local machine:

```bash
   git clone https://github.com/yourusername/weather_app.git
   cd weather_app
```

2. **Install dependencies**:
   Make sure you have the necessary Ruby gems installed:
   `bundle install`

3. **Setup environment variables**:
   Create a .env file (if not already present) in the root of the project to store your weather API key. You can get an API key from a service like OpenWeather or another weather API provider.

   Example of .env file:
   WEATHER_API_KEY=your_api_key_here
   Make sure to replace your_api_key_here with your actual API key.

4. **Set up the database**:
   Run the following commands to set up the database and run any migrations:

   ````rails db:create
   rails db:migrate```

   ````

5. **Start the Rails server**:
   Start the local Rails development server:

   `rails server`
   This will start the server at `http://localhost:3000`.

6. **Visit the app**:
   Open your web browser and navigate to `http://localhost:3000`. You should be able to enter a location, view the 7-day weather forecast, and see the temperature chart.

Notes
Make sure to replace any placeholder values (like your_api_key_here) with actual data, such as your API key.
If you encounter any issues with missing gems or dependencies, try running bundle install again or check your environment setup.
You can customize the layout and styling of the app to fit your needs.
Enjoy using the Weather App!
