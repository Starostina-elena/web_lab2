package models;

public class ResultRow {

    private double x;
    private double y;
    private double r;
    private boolean isHit;
    private String startTime;

    public ResultRow(double x, double y, double r, String startTime) {
        this.x = x;
        this.y = y;
        this.r = r;
        isHit = x <= 0 && y >= 0 && x >= -r && y <= r / 2 ||
                x <= 0 && y <= 0 && x * x + y * y <= r * r ||
                x >= 0 && y <= 0 && x <= r && y >= x / 2 - r / 2;
        this.startTime = startTime;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public boolean isHit() {
        return isHit;
    }

    public String getStartTime() {
        return startTime;
    }
}
