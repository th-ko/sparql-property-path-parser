declare function parse(text: string): AST 

export type AST = Sequence | Alternative | Primitive

export interface Sequence {
  type: 'sequence'
  paths: AST[]
}
export interface Alternative {
  type: 'alternative'
  paths: AST[]
}
export interface Primitive {
  path: string
  modifier?: Modifier 
}
export interface Modifier {
  min: number
  max: number
}