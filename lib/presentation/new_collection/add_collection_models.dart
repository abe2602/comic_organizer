abstract class AddCollectionStateResponse {}

abstract class AddCollectionAction {}

class Loading implements AddCollectionStateResponse {}

class Idle implements AddCollectionStateResponse {}

class Success implements AddCollectionAction {}

abstract class Error implements AddCollectionAction {}

class CollectionAlreadyAddedError implements Error {}

class GenericError implements Error {}
