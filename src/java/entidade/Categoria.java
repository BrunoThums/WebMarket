package entidade;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class Categoria {

    public Integer id;
    public String descricao; //nome
    public Date criado_em;
    public Date atualizado_em;
    public String ativo; //ativo (visível) ou inativo (invisível)
    
    public static Categoria from(ResultSet resultSet) throws SQLException {
        Categoria cat = new Categoria();

        cat.id = resultSet.getInt("id");
        cat.descricao = resultSet.getString("descricao");
        cat.criado_em = resultSet.getDate("created_at");
        cat.atualizado_em = resultSet.getDate("updated_at");
        cat.ativo = resultSet.getString("ativo");

        return cat;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("categoria{id=").append(id);
        sb.append("', descricao='").append(descricao);
        sb.append("', created_at='").append(criado_em);
        sb.append("', updated_at='").append(atualizado_em);
        sb.append("', ativo='").append(ativo);
        sb.append('}');
        return sb.toString();
    }
}
