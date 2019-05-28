export interface Type {
  flags: TypeFlags
}

export const enum TypeFlags {
  Any = 1 << 0,
  Int = 1 << 1,
  Address = 1 << 2,
  Mapping = 1 << 3,
  Array = 1 << 4,
  Bool = 1 << 5,
}
