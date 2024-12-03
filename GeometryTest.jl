using Geometry
using Test

function ==(p1::Point2D, p2::Point2D)
    return isapprox(p1.x, p2.x) && isapprox(p1.y, p2.y)
end

@testset "Point2D Type Tests" begin
    @test isa(Point2D(1, 2),Point2D)
    @test isa(Point2D(1.0, 2.0),Point2D)
    @test isa(Point2D(1, 2.0),Point2D)

    # Testing string constructor
    @test isa(Point2D("(1,2)"),Point2D)
    @test isa(Point2D("(1.5,2.5)"),Point2D)
    @test isa(Point2D("(3.0, 4.0)"),Point2D)
end

@test Point2D("(1,2)") == Point2D(1, 2)


@test Point2D("(1.5, 2.5)") == Point2D(1.5, 2.5)

@test Point2D("(0.0, 0.0)") == Point2D(0.0,0.0)

@testset "Point3D Type Tests" begin
    @test isa(Point3D(1, 2, 3),Point3D)
    @test isa(Point3D(1.0, 2.0, 3.0),Point3D)
    @test isa(Point3D(1, 2.5, 3),Point3D)
end

@testset "Polygon Type Tests" begin
    @test isa(Polygon([Point2D(0, 0), Point2D(1, 0), Point2D(0, 1)]),Polygon)

    @test isa(Polygon([Point2D(0, 0), Point2D(2, 0), Point2D(2, 1), Point2D(0, 1)]),Polygon)

    @test isa(Polygon([Point2D(0, 0), Point2D(2, 0), Point2D(3, 1), Point2D(1, 1)]),Polygon)
end

@testset "Polygon Constructor Consistency" begin
    points = [Point2D(0, 0), Point2D(1, 0), Point2D(0, 1)]
    @test Polygon(points) == Polygon([0.0, 0.0, 1.0, 0.0, 0.0, 1.0])
end

@testset "Polygon Constructor Error Handling" begin
    @test_throws ArgumentError Polygon([1.0, 2.0, 3.0])  # Odd number of coordinates
    @test_throws ArgumentError Polygon([Point2D(0, 0), Point2D(1, 0)])  # Less than 3 vertices
end

@testset "Distance Function Tests" begin
    @test isapprox(distance(Point2D(0, 0), Point2D(3, 4)), sqrt(3^2 + 4^2))
    @test isapprox(distance(Point2D(1, 1), Point2D(4, 5)), sqrt(3^2 + 4^2))
    @test isapprox(distance(Point2D(0, 0), Point2D(0, 5)), sqrt(5^2))
end

@testset "Perimeter Function Tests" begin
    triangle = Polygon([Point2D(0, 0), Point2D(3, 0), Point2D(3, 4)])
    @test isapprox(perimeter(triangle), 3 + 4 + 5)

    rectangle = Polygon([Point2D(0, 0), Point2D(4, 0), Point2D(4, 3), Point2D(0, 3)])
    @test isapprox(perimeter(rectangle), 2 * (4 + 3))

    parallelogram = Polygon([Point2D(0, 0), Point2D(3, 0), Point2D(4, 2), Point2D(1, 2)])
    @test isapprox(perimeter(parallelogram), 2 * (sqrt(3^2 + 0^2) + sqrt(1^2 + 2^2)))
end

