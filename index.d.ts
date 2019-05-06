declare function parse(text: string): AST;

export type AST = Sequence | Alternative | Inverse | Primitive;

export interface Sequence {
  type: "sequence";
  paths: AST[];
}
export interface Alternative {
  type: "alternative";
  paths: AST[];
}
export interface Inverse {
  type: "inverse";
  path: Primitive;
}
export interface Primitive {
  path: string;
  modifier?: Modifier;
}
export interface Modifier {
  min: number;
  max: number;
}
