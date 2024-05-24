from Functions.Calculator.compuTex.module.computex import *

def expandC(latex_expr):
    expr = parse_latex_extended(latex_expr)
    evaluated_sympy_expr = expr.doit()
    evaluated_sympy_expr = evaluated_sympy_expr.expand()
    evaluated_latex_expr = latex(evaluated_sympy_expr)
    output_matrix_begin = "\\begin{pmatrix}"
    output_matrix_end = "\\end{pmatrix}"
    evaluated_latex_expr = uniformize_matrix_delimiters(evaluated_latex_expr,
                                                        output_matrix_begin,
                                                        output_matrix_end)
    return evaluated_latex_expr

def factorC(latex_expr):
    expr = parse_latex_extended(latex_expr)
    evaluated_sympy_expr = expr.doit()
    evaluated_sympy_expr = evaluated_sympy_expr.factor()
    evaluated_latex_expr = latex(evaluated_sympy_expr)
    output_matrix_begin = "\\begin{pmatrix}"
    output_matrix_end = "\\end{pmatrix}"
    evaluated_latex_expr = uniformize_matrix_delimiters(evaluated_latex_expr,
                                                        output_matrix_begin,
                                                        output_matrix_end)
    return evaluated_latex_expr

def simplifyC(latex_expr):
    expr = parse_latex_extended(latex_expr)
    evaluated_sympy_expr = expr.doit()
    evaluated_sympy_expr = simplify(evaluated_sympy_expr)
    evaluated_latex_expr = latex(evaluated_sympy_expr)
    output_matrix_begin = "\\begin{pmatrix}"
    output_matrix_end = "\\end{pmatrix}"
    evaluated_latex_expr = uniformize_matrix_delimiters(evaluated_latex_expr,
                                                        output_matrix_begin,
                                                        output_matrix_end)
    return evaluated_latex_expr