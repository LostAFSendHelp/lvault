extension Cast on Object {
  T? cast<T>() => this is T ? this as T : null;

  T castOr<T>(T defaultValue) => this is T ? this as T : defaultValue;
}
