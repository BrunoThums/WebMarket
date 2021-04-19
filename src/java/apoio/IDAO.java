package apoio;

import java.util.ArrayList;

public interface IDAO <T> {

    public String salvar (T objeto);

    public String atualizar(T o);

    public String excluir(int id);

    public ArrayList<T> consultarTodos();
   
    public boolean registroUnico(T o);

    public ArrayList<T> consultar(String criterio);

    public T consultarId(int id);
    
    public boolean consultar (T o);
}
