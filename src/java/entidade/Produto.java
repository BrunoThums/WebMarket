package entidade;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Produto {

    public Integer id;
    public String descricao; //nome
    public double valor; //valor unitário
    public Integer estoque; //quantidade de produtos disponíveis
    public String unidade; //kilos ou unidades
    public Integer id_categoria; //puxa o nome da categoria baseado no id
    public String ativo; //ativo (visível) ou inativo (invisível)

    public static Produto from(ResultSet resultSet) throws SQLException {
        Produto prod = new Produto();

        prod.id = resultSet.getInt("id");
        prod.descricao = resultSet.getString("descricao");
        prod.valor = resultSet.getDouble("valor");
        prod.estoque = resultSet.getInt("estoque");
        prod.unidade = resultSet.getString("unidade");
        prod.id_categoria = resultSet.getInt("id_categoria");
        prod.ativo = resultSet.getString("ativo");

        return prod;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("produto{id=").append(id);
        sb.append("', descricao='").append(descricao);
        sb.append("', valor='").append(valor);
        sb.append("', estoque='").append(estoque);
        sb.append("', unidade='").append(unidade);
        sb.append("', id_categoria='").append(id_categoria);
        sb.append("', ativo='").append(ativo);
        sb.append('}');
        return sb.toString();
    }
}
