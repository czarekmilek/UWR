class StopienWojskowy implements Comparable<StopienWojskowy> {
    private String nazwa;
    protected int ranga;

    public StopienWojskowy(String nazwa) {
        this.nazwa = nazwa;
    }

    public String getNazwa() {
        return nazwa;
    }

    public int getRanga() {
        return ranga;
    }

    @Override
    public String toString() {
        return nazwa;
    }

    @Override
    public int compareTo(StopienWojskowy o) {
        if (this.ranga == o.ranga) {
            return nazwa.compareTo(o.nazwa);
        }
        return Integer.compare(this.ranga, o.ranga);
    }
}
