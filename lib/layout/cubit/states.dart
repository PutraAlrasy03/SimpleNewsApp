abstract class NewsStates {}
class NewsInitialState extends NewsStates{}
class NewsBottomNavState extends NewsStates{}
class ModeStateChange extends NewsStates{}

class NewsbusinessLoading extends NewsStates{}
class NewsbusinessSuccess extends NewsStates{}
class NewsbusinessError extends NewsStates{
  final String error;
  NewsbusinessError(this.error);
}

class NewsSportsLoading extends NewsStates{}
class NewsSportsSuccess extends NewsStates{}
class NewsSportsError extends NewsStates{
  final String error;
  NewsSportsError(this.error);
}

class NewsScienceLoading extends NewsStates{}
class NewsScienceSuccess extends NewsStates{}
class NewsScienceError extends NewsStates{
  final String error;
  NewsScienceError(this.error);
}

class NewsSearchLoading extends NewsStates{}
class NewsSearchSuccess extends NewsStates{}
class NewsSearchError extends NewsStates{
  final String error;
  NewsSearchError(this.error);
}

