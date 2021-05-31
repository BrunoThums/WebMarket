package entidade;

import java.io.Serializable;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Produto implements Serializable{

    public Integer id;
    public String nome; //nome
    public String descricao; //descrição detalhada do produto
    public double valor; //valor unitário
    public Integer estoque; //quantidade de produtos disponíveis
    public Integer id_categoria; //puxa o nome da categoria baseado no id
    public String ativo; //ativo (visível) ou inativo (invisível)
    public String file; // Salva uma Img

    public static Produto from(ResultSet resultSet) throws SQLException  {
        Produto prod = new Produto();

        prod.id = resultSet.getInt("id");
        prod.descricao = resultSet.getString("descricao");
        prod.valor = resultSet.getDouble("valor");
        prod.estoque = resultSet.getInt("estoque");
        prod.id_categoria = resultSet.getInt("id_categoria");
        prod.ativo = resultSet.getString("ativo");
        prod.nome = resultSet.getString("nome");
        prod.file = resultSet.getString("file");

        return prod;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("produto{id=").append(id);
        sb.append("', descricao='").append(descricao);
        sb.append("', valor='").append(valor);
        sb.append("', estoque='").append(estoque);
        sb.append("', id_categoria='").append(id_categoria);
        sb.append("', ativo='").append(ativo);
        sb.append("', nome='").append(nome);
        sb.append("', file='").append(file);
        sb.append('}');
        return sb.toString();
    }
}
