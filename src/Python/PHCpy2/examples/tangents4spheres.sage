"""
Sage 7.4 code to generate the polynomial system for the problem
of all lines tangent to four given spheres.
This scripts runs typing sage tangents4spheres.sage at the command prompt,
provided the python interpreter of sage is extended with phcpy.
"""
def tangent_system(centers, radii, verbose=True):
    """
    Returns a tuple with the list of polynomials
    and variables for the common tangents to four
    spheres with given centers and squares of radii.
    """
    x0, x1, x2 = var('x0, x1, x2')
    t = (x0, x1, x2) 
    vt = vector(t)   # tangent vector
    normt = vt.dot_product(vt) - 1
    if verbose:
        print 'normalized tangent :'
        print normt
    x3, x4, x5 = var('x3, x4, x5')
    m = (x3, x4, x5)
    vm = vector(m)   # moment vector
    momt = vt.dot_product(vm)
    if verbose:
        print 'moment is perpendicular to tangent :'
        print momt
    eqs = [normt, momt]
    for (ctr, rad) in zip(centers, radii):
        print 'the center :', ctr
        vc = vector(ctr)
        left = vm - vc.cross_product(vt)
        equ = left.dot_product(left) - rad**2
        if verbose:
            print equ
        eqs.append(equ)
    vrs = [x0, x1, x2, x3, x4, x5]
    return eqs, vrs

def quadruples():
    """
    If each pair of the four given spheres touch each other, then the
    tangent lines connect the points where the spheres touch each other.
    In that case, the tangent lines then have multiplicity four.
    This function returns the centers and the radii of the four
    spheres as a tuple of two lists.
    """
    c0 = (+1, +1, +1)
    c1 = (+1, -1, -1)
    c2 = (-1, +1, -1)
    c3 = (-1, -1, +1)
    ctr = [c0, c1, c2, c3]
    rad = [sqrt(2) for _ in range(4)]
    return (ctr, rad)

def doubles():
    """
    Returns the centers and the radii for a case where the solutions 
    occur with multiplicity two.  The reference for this case is
    the paper by Frank Sottile and Thorsten Theobald:
    "Line problems in nonlinear computational geometry"
    In Computational Geometry - Twenty Years Later, pages 411-432,
    edited by J.E. Goodman, J. Pach, and R. Pollack, AMS, 2008.
    """
    c0 = (2, 2, 0)
    c1 = (2, 0, 2)
    c2 = (0, 2, 2)
    c3 = (0, 0, 0)
    ctr = [c0, c1, c2, c3]
    rad = [3/2 for _ in range(4)]
    return (ctr, rad)

def tostrings(eqs):
    """
    Returns the string representations of the equations
    for input to the solve of phcpy.
    """
    result = []
    for equ in eqs:
        pol = str(equ) + ';'
        result.append(pol)
    return result

def real_coordinates(vars, sols):
    """
    Given in vars the string representations of the variables
    and in sols the list of solutions in string format, returns
    the real parts of the coordinates of the solutions as tuples,
    collected in a list.
    """
    from phcpy.solutions import coordinates
    result = []
    for sol in sols:
        (names, values) = coordinates(sol)
        crd = []
        for var in vars:
            idx = names.index(var)
            nbr = values[idx].real
            crd.append((nbr if abs(nbr) > 1.e-12 else 0.0))
        result.append(tuple(crd))
    return result

def crosspoint(tan, mom, verbose=True):
    """
    Given a tangent vector and moment vector,
    computes a point, solving for m = p x t.
    """
    if verbose:
        print 't =', tan
        print 'm =', mom
    A = Matrix(RR, [[0, tan[2], -tan[1]], \
                    [-tan[2], 0, tan[0]], \
                    [tan[1], -tan[0], 0]])
    if verbose:
        print A
    sol = A\vector(RR,mom)
    if verbose:
        print 'x =', sol
    return sol

def tangent_lines(solpts):
    """
    Given the list of solution points in solpts, returns the list of 
    tuples which represent the lines.  Each tuple contains a point on 
    the line and the tangent vector.
    """
    result = []
    for point in solpts:
        print point
        tan = vector(point[0:3])
        mom = vector(point[3:6])
        pnt = crosspoint(tan, mom)
        result.append((pnt, tan))
    return result

def plot_quadruple_spheres(ctr, rad):
    """
    Returns the spheres with centers in ctr and radii in rad
    as golden balls, for the multiplicity four tangent lines.
    """
    x, y, z = var('x, y, z')
    eqs = [(x - c[0])^2 + (y - c[1])^2 + (z - c[2])^2 - r^2 \
        for (c, r) in zip(ctr, rad)]
    xr = (x, -3, 3)
    yr = (y, -3, 3)
    zr = (z, -3, 3)
    balls = [implicit_plot3d(equ, xr, yr, zr, color='gold') for equ in eqs]
    return sum(balls)

def plot_double_spheres(ctr, rad):
    """
    Returns the spheres with centers in ctr and radii in rad
    as golden balls, for the multiplicity two tangent lines.
    """
    x, y, z = var('x, y, z')
    eqs = [(x - c[0])^2 + (y - c[1])^2 + (z - c[2])^2 - r^2 \
        for (c, r) in zip(ctr, rad)]
    xr = (x, -2, 4)
    yr = (y, -2, 4)
    zr = (z, -2, 4)
    balls = [implicit_plot3d(equ, xr, yr, zr, color='gold') for equ in eqs]
    return sum(balls)

def plot_quadruple_tangents(lines):
    """
    Given in lines the coordinates of the points and the tangents,
    returns the plot of the lines in the range [-3, +3] for all three
    coordinates, in the case of the tangents of multiplicity four.
    """
    points = [pnt for (pnt, tan) in lines]
    tangents = [tan for (pnt, tan) in lines]
    a1 = vector(RR, points[0]) + 3*vector(RR, tangents[0])
    a2 = vector(RR, points[2]) + 3*vector(RR, tangents[2])
    a3 = vector(RR, points[4]) + 3*vector(RR, tangents[4])
    b1 = vector(RR, points[0]) - 3*vector(RR, tangents[0])
    b2 = vector(RR, points[2]) - 3*vector(RR, tangents[2])
    b3 = vector(RR, points[4]) - 3*vector(RR, tangents[4])
    L1 = line([a1, b1], thickness=10, color='red')
    L2 = line([a2, b2], thickness=10, color='blue')
    L3 = line([a3, b3], thickness=10, color='green')
    fig = L1 + L2 + L3
    return fig

def plot_double_tangents(lines):
    """
    Given in lines the coordinates of the points and the tangents,
    plots the lines in the range [-2, 4] for the x, y, z coordinates,
    for the case of the tangents of multiplicity two.
    """
    points = [pnt for (pnt, tan) in lines]
    tangents = [tan for (pnt, tan) in lines]
    a1 = vector(RR, points[0]) + 3*vector(RR, tan[0][1])
    a2 = vector(RR, points[2]) + 3*vector(RR, tan[2][1])
    a3 = vector(RR, points[4]) + 3*vector(RR, tan[4][1])
    a4 = vector(RR, points[6]) + 3*vector(RR, tan[6][1])
    a5 = vector(RR, points[8]) + 5*vector(RR, tan[8][1])
    a6 = vector(RR, points[9]) + 3*vector(RR, tan[9][1])
    b1 = vector(RR, points[0]) - 5*vector(RR, tan[0][1])
    b2 = vector(RR, points[2]) - 5*vector(RR, tan[2][1])
    b3 = vector(RR, points[4]) - 5*vector(RR, tan[4][1])
    b4 = vector(RR, points[6]) - 5*vector(RR, montans[6][1])
    b5 = vector(RR, points[8]) - 3*vector(RR, montans[8][1])
    b6 = vector(RR, points[9]) - 5*vector(RR, montans[9][1])
    L0 = line([a1, b1], thickness=10, color='red')
    L1 = line([a2, b2], thickness=10, color='blue')
    L2 = line([a3, b3], thickness=10, color='green')
    L3 = line([a4, b4], thickness=10, color='black')
    L4 = line([a5, b5], thickness=10, color='orange')
    L5 = line([a6, b6], thickness=10, color='purple')
    fig = L0 + L1 + L2 + L3 + L4 + L5
    return fig

def main():
    """
    Solves the problem of computing all tangent lines
    to four given spheres.
    """
    ans = raw_input('Double lines ? (y/n) ')
    dbl = (ans == 'y')
    if dbl:
        (ctr, rad) = doubles()
    else:
        (ctr, rad) = quadruples()
    eqs, vrs = tangent_system(ctr, rad)
    print 'the polynomial system :'
    for equ in eqs:
        print equ
    pols = tostrings(eqs)
    for pol in pols:
        print pol
    print 'calling the solver of phcpy :'
    from phcpy.solver import solve
    sols = solve(pols, silent=True)
    print 'the solutions :'
    for sol in sols:
        print sol
    vars = ['x0', 'x1', 'x2', 'x3', 'x4', 'x5']
    pts = real_coordinates(vars, sols)
    print 'the coordinates of the solution points :'
    for point in pts:
        print point
    lines = tangent_lines(pts)
    print 'the tangent lines :'
    for line in lines:
        print line
    if dbl:
        fig1 = plot_double_spheres(ctr, rad)
        fig2 = plot_double_tangents(lines)
    else:
        fig1 = plot_quadruple_spheres(ctr, rad)
        fig2 = plot_quadruple_tangents(lines)
    (fig1+fig2).save('tangents.png')

main()