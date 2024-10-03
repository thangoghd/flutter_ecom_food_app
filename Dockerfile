FROM cirrusci/flutter:stable

WORKDIR /app

# Copy pubspec files
COPY pubspec.* ./

# Get dependencies
RUN flutter pub get

# Copy the rest of the files
COPY . .

# Build the app for web as an example
RUN flutter build web

# Command to run the app
CMD ["flutter", "run", "-d", "web-server", "--web-port", "8080", "--web-hostname", "0.0.0.0"]