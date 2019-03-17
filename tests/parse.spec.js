var {parse} = require('../index')

describe('property path parser', () => {
 it('can parse simple sequences', () => {
    const ast = parse('propOne/propTwo/propThree')
    expect(ast).toMatchSnapshot()
 })
 it('can parse complex paths', () => {
    const ast = parse('altOnePropOne{1,}/altOnePropTwo+|altTwoPropOne*/propThree{3}')
    expect(ast).toMatchSnapshot()
 })
 it('can parse path with spaces', () => {
    const ast = parse('propOne / ( altPropOne | altPropTwo)/propThree*')
    expect(ast).toMatchSnapshot()
 })
 it('can inline sequences that are backeted', () => {
    const ast = parse('propOne / ( propTwo / propThree)/(propFour/propFive)')
    expect(ast).toMatchSnapshot()
 })
})