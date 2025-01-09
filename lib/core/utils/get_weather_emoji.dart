String getWeatherEmoji(String condition) {
  switch (condition.toLowerCase()) {
    case "sunny":
      return "☀️";
    case "rainy":
      return "🌧️";
    case "clear":
      return "(:";
    case "cloudy":
      return "☁️";
    case "snowy":
      return "❄️";
    case "thunderstorm":
      return "🌩️";
    default:
      return "🌡️"; // Default emoji for unknown conditions
  }
}