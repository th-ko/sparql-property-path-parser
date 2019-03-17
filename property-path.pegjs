// SPARQL 1.1 Property Paths
// https://www.w3.org/TR/sparql11-property-paths/#path-syntax

Path 
  =	PathAlternative
 
PathAlternative
  = first:PathSequence rest:( '|'  PathSequence)* {
    if (rest.length === 0) return first
    let paths = [first, ...(rest.map(r => r[1]))]
    paths = paths.reduce((c,x) => {
    	return x.type && x.type === 'alternative' 
        	? [...c, ...x.paths]
            : [...c, x]
    }, [])
    return { type: 'alternative', paths }
  }
  
PathSequence 
  = first:PathEltOrInverse _ rest:PathSequenceRest* {
    if (rest.length === 0) return first
    let paths = [first, ...rest]
    paths = paths.reduce((c,x) => {
    	return x.type && x.type === 'sequence' 
        	? [...c, ...x.paths]
            : [...c, x]
    }, [])
    return { type: 'sequence', paths }
  }
  
PathSequenceRest 
 = '/' path:PathEltOrInverse { return path }
 / '^' path:PathElt { return {type: 'inverse', path: path.path} }
  
PathEltOrInverse
  =	'^' path:PathElt { return {type: 'inverse', path} }
      / path:PathElt { return path }
  
PathElt	 
  = path:PathPrimary modifier:PathMod? { return modifier ? { path, modifier} : path }
  
PathMod
  =	'*' { return {min:0, max:Infinity} }
  / '?' { return {min:0, max:1}}
  / '+' { return {min:1, max:Infinity} }
  / '{' min:Integer _ ',' _ max:Integer _ '}' { return {min, max} }
  / '{' min:Integer _ ',' _ '}' { return {min, max: Infinity} }
  / '{' num:Integer _ '}' { return {min: num, max: num } }
  
PathPrimary	
  = _ path:IRIref _ { return { path } }
  / _ '(' path: Path ')' _ { return path }
  
IRIref "iriref"
  = predicate:[a-zA-Z_:]+ { return predicate.join('') }

Integer "integer"
  = _ [0-9]+ { return parseInt(text(), 10); }

_ "whitespace"
  = [ \t\n\r]* 

              