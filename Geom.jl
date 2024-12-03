module Geometry

export Point2D, Polygon, Point3D, distance, perimeter, isRectangular

"""
Represents a 2D point with 'x' and 'y' coordinates, both of the type 'Real'.
"""
struct Point2D
    x::Real
    y::Real
end

"""
Custom display for 'Point 2D' objects, showing the point in the format '(x,y)'.
"""
function Base.show(io::IO, p::Point2D)
    print(io, "(", p.x, ", ", p.y, ")")
end

"""
Determines if two 'Point2D' object are equal.
"""
function ==(p1::Point2D, p2::Point2D)
    return isapprox(p1.x, p2.x) && isapprox(p1.y, p2.y)
end

"""
Calculates the Euclidean distance between two 'Point2D' points.
    Returns the distance between 'p1' and 'p2' as a 'Real'.
"""
function distance(p1::Point2D, p2::Point2D)
    sqrt((p2.x - p1.x)^2 + (p2.y - p1.y)^2)
end

"""
Represents a 3D point with 'x', 'y', and 'z' coordinates, all of the type 'Real'.
"""
struct Point3D
    x::Real
    y::Real
    z::Real
end

"""
Custom display for 'Point 3D' objects, showing the point in the format '(x,y,z)'.
"""
function Base.show(io::IO, p::Point3D)
    print(io, "(", p.x, ", ", p.y, ", ", p.z, ")")
end

"""
Determines if two 'Point3D' objects are equal.
"""
function ==(p1::Point3D, p2::Point3D)
    return isapprox(p1.x, p2.x) && isapprox(p1.y, p2.y) && isapprox(p1.z, p2.z)
end

"""
Represents a polygon defined by a vector of 'Point2D' objects, A 'Polygon' must have at least three points.
"""
struct Polygon
    points::Vector{Point2D}
    function Polygon(pts::Vector{Point2D})
        if length(pts) < 3
            throw(ArgumentError("A polygon must have at least 3 points."))
        end
        new(pts)
    end
    function Polygon(coords::Vector{<:Real})
        if length(coords) % 2 != 0
            throw(ArgumentError("The number of coordinates must be even to form pairs of (x, y)."))
        end
    
        # Create pairs of coordinates
        points = [Point2D(coords[i], coords[i+1]) for i in 1:2:length(coords)-1]
        Polygon(points)  # Call the inner constructor
    end
    function Polygon(coords::Real...)
        Polygon(collect(coords))
    end
end

"""
Custom display for 'Polygon' objects.
"""
function Base.show(io::IO, poly::Polygon)
    points_str = join([string(p) for p in poly.points], ", ")
    print(io, "Polygon(", points_str, ")")
end

"""
Determines if two 'Polygon' objects are equal.
"""
function ==(poly1::Polygon, poly2::Polygon)
    return length(poly1.points) == length(poly2.points) &&
           all(==(p1, p2) for (p1, p2) in zip(poly1.points, poly2.points))
end

"""
Calculates the perimeter of a polygon by summing the distances between consecutive 'Point2D' vertices.
    Returns the perimeter as a 'Real'.
"""
function perimeter(polygon::Polygon)
    points = polygon.points
    n = length(points)
    total_distance = 0.0
    for i in 1:n-1
        total_distance += distance(points[i], points[i+1])
    end
    total_distance += distance(points[n], points[1])
    return total_distance
end

"""
Determines if a polygon with exactly four vertices forms a rectangle.
The polygon is rectangular if the distance between opposite vertices is equal.
    Returns 'true' if the polygon is rectangular, 'false' otherwise.
"""
function isRectangular(polygon::Polygon)
    points = polygon.points
    if length(points) != 4
        return false
    end
    d1 = distance(points[1], points[3])
    d2 = distance(points[2], points[4])
    return isapprox(d1, d2)
end




end