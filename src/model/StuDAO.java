package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class StuDAO {
    SimpleDateFormat sdf2=new SimpleDateFormat("yyyy-MM-dd");
	SimpleDateFormat sdf=new SimpleDateFormat("yyyy�� MM�� dd��");
    DecimalFormat df=new DecimalFormat("#,###��");

    //�л�����
    public StuVO read(String scode) {
    	StuVO vo=new StuVO();
    	try {
    		String sql="select * from stu where scode=?";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ps.setString(1, scode);
    		ResultSet rs=ps.executeQuery();
    		if(rs.next()) {
    			vo.setScode(rs.getString("scode"));
    			vo.setSname(rs.getString("sname"));
    			vo.setDept(rs.getString("dept"));
    			vo.setYear(rs.getString("year"));
    			vo.setAdvisor(rs.getString("advisor"));
    			vo.setBirthday(sdf2.format(rs.getDate("birthday")));
    			vo.setPname(rs.getString("pname"));
    		}
    	}catch(Exception e) {
    		System.out.println("�л�����:" + e.toString());
    	}
    	return vo;
    }
    //�л����
    public void insert(StuVO vo) {
    	try {
    		String sql="insert into students(scode,sname,dept,year,birthday,advisor) values(?,?,?,?,?,?)";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ps.setString(1, vo.getScode());
    		ps.setString(2, vo.getSname());
    		ps.setString(3, vo.getDept());
    		ps.setString(4, vo.getYear());
    		ps.setString(5, vo.getBirthday());
    		ps.setString(6, vo.getAdvisor());
    		ps.execute();
    	}catch(Exception e) {
    		System.out.println("�������:" + e.toString());
    	}
    }
    
    //���л��ڵ�
    public String getCode() {
    	String code="";
    	try {
    		String sql="select max(scode)+1 code from students";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ResultSet rs=ps.executeQuery();
    		if(rs.next()) code=rs.getString("code");
    	}catch(Exception e) {
    		System.out.println("���л��ڵ�:" + e.toString());
    	}
    	return code;
    }
    
	//�л����
	public JSONObject list(SqlVO vo) {
		JSONObject object=new JSONObject();
		try {
			String sql="call list('stu',?,?,?,?,?,?)";
			CallableStatement cs=Database.CON.prepareCall(sql);
			cs.setString(1, vo.getKey());
			cs.setString(2, vo.getWord());
			cs.setString(3, vo.getOrder());
			cs.setString(4, vo.getDesc());
			cs.setInt(5, vo.getPage());
			cs.setInt(6, vo.getPer());
			cs.execute();
			
			ResultSet rs=cs.getResultSet();
			JSONArray jArray=new JSONArray();
			while(rs.next()) {
				JSONObject obj=new JSONObject();
				obj.put("scode", rs.getString("scode"));
				obj.put("sname", rs.getString("sname"));
				obj.put("dept", rs.getString("dept"));
				obj.put("year", rs.getString("year"));
				obj.put("birthday", sdf.format(rs.getDate("birthday")));
				obj.put("advisor", rs.getString("advisor"));
				obj.put("pname", rs.getString("pname"));
				obj.put("pdept", rs.getString("pdept"));
				jArray.add(obj);
			}
			object.put("array", jArray);
			
			cs.getMoreResults();
			rs=cs.getResultSet();
			
			int total=0;
			
			if(rs.next()) total=rs.getInt("total");
			
			int last=total%vo.getPer()==0 ? total/vo.getPer():
				total/vo.getPer()+1;
			
			object.put("total", total);			
			object.put("last", last);
			
		}catch(Exception e) {
			System.out.println("�л����:" + e.toString());
		}
		return object;
	}
}
