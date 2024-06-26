// By default all files related to Api Keys must be added in .gitgnore,
// but in this project, to employers' testability reasons, it will not be added
// on .gitgnore, but if it was a real production app, it would be in gitgnore.

/// Api Keys used in project.
class ApiKeys {
  /// ApiKey to access API URL
  static const nasaApiKey = 'pejaih922qYbtoR4Sbh5yCS2lOtBqvXkcZow9tVV';

  /// Api Url to connect with Nasa service
  static const apiURl =
      'https://api.nasa.gov/planetary/apod?api_key=$nasaApiKey';
}
