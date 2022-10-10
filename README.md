# Tourniquet

Runtime introspection to detect which features caused a crash

## Usage

In a function that you want to associate with a specific feature
```
tourniquet.register("some_feature_identifier")
```

Next launch after a crash, pass in the stack trace to compare against the previously recorded features
```
if let featureIdentifier = tourniquet.handlePendingCrash(stackTrace) {
    // Disable your crashing feature
}
```
