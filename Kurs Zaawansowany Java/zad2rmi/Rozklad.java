import java.rmi.Remote;
import java.rmi.RemoteException;
import java.util.LinkedList;

public interface Rozklad extends Remote {
    public LinkedList<Long> naCzynnikiPierwsze(long x) throws RemoteException;
}
