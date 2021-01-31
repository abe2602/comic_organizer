abstract class ComicOrganizerException implements Exception {}

class NoInternetException implements ComicOrganizerException {}

class GenericException implements ComicOrganizerException {}

class EmptyCachedListException implements ComicOrganizerException {}

class NameAlreadyAddedException implements ComicOrganizerException {}

class CachedMovieDetailNotFoundException implements ComicOrganizerException {}

class UnexpectedException implements ComicOrganizerException {}

abstract class FormFieldException implements ComicOrganizerException {}

class EmptyFormFieldException implements FormFieldException {}

class InvalidFormFieldException implements FormFieldException {}
