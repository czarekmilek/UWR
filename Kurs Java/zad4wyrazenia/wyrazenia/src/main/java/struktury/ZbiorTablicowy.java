package struktury;

import java.util.Arrays;

public class ZbiorTablicowy implements Zbior, Cloneable {
    private Para[] zbior;
    private int zapelnienie = 0;

    public ZbiorTablicowy(int rozmiar) {
        zbior = new Para[rozmiar];
    }

    @Override
    public Para szukaj(String k) {
        for (Para para : zbior) {
            if (para != null && para.klucz.equals(k)) return para;
        }
        return null;
    }

    @Override
    public void wstaw(Para p) {
        for (int i = 0; i < zapelnienie; i++) {
            if (zbior[i].klucz.equals(p.klucz)) {
                zbior[i].setWartosc(p.getWartosc());
                return;
            }
        }
        if (zapelnienie >= zbior.length) throw new IllegalStateException("Tablica jest pelna.");
        zbior[zapelnienie++] = p;
    }

    @Override
    public void usun(String k) {
        for (int i = 0; i < zapelnienie; i++) {
            if (zbior[i].klucz.equals(k)) {
                zbior[i] = zbior[--zapelnienie];
                zbior[zapelnienie] = null;
                return;
            }
        }
    }

    @Override
    public void czysc() {
        Arrays.fill(zbior, 0, zapelnienie, null);
        zapelnienie = 0;
    }

    @Override
    public boolean pusty() {
        return zapelnienie == 0;
    }

    @Override
    public int ile() {
        return zapelnienie;
    }

    @Override
    public ZbiorTablicowy clone() {
        ZbiorTablicowy kopia = new ZbiorTablicowy(zbior.length);
        for (int i = 0; i < zapelnienie; i++) {
            kopia.zbior[i] = zbior[i].clone();
        }
        kopia.zapelnienie = zapelnienie;
        return kopia;
    }
}
