package model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class CouDAO {
	CouVO vo=new CouVO();
	
	//°­ÁÂµî·Ï
    public void insert(CouVO vo) {
    	try {
    		String sql="insert into courses(lcode,lname,room,hours,instructor,capacity) values(?,?,?,?,?,?)";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ps.setString(1, vo.getLcode());
    		ps.setString(2, vo.getLname());
    		ps.setString(3, vo.getRoom());
    		ps.setInt(4, vo.getHours());
    		ps.setString(5, vo.getInstructor());
    		ps.setInt(6, vo.getCapacity());
    		ps.execute();
    	}catch(Exception e) {
    		System.out.println("°­ÁÂµî·Ï:" + e.toString());
    	}
    }
	
    //»õ°­ÁÂÄÚµå
    public String getCode() {
    	String code="";
    	try {
    		String sql="select concat('N', max(substring(lcode,2,3))+1) code from courses";
    		PreparedStatement ps=Database.CON.prepareStatement(sql);
    		ResultSet rs=ps.executeQuery();
    		if(rs.next()) {
    			code= rs.getString("code");
    		}	
    	}catch(Exception e) {
    		System.out.println("»õ°­ÁÂÄÚµå:" + e.toString());
    	}
    	return code;
    }
	
	//°­ÁÂÁ¤º¸
	public CouVO read(String lcode) {
		try {
			String sql="select * from cou where lcode=?";
			PreparedStatement ps=Database.CON.prepareStatement(sql);
			ps.setString(1, lcode);
			ResultSet rs=ps.executeQuery();
			if(rs.next()) {
				vo.setLcode(rs.getString("lcode"));
				vo.setLname(rs.getString("lname"));
				vo.setRoom(rs.getString("room"));
				vo.setCapacity(rs.getInt("capacity"));
				vo.setPersons(rs.getString("persons"));
				vo.setHours(rs.getInt("hours"));
				vo.setInstructor(rs.getString("instructor"));
				vo.setPname(rs.getString("pname"));
				vo.setDept(rs.getString("dept"));
				
			}
		} catch (Exception e) {
			System.out.println("°­ÁÂÁ¤º¸:"+e.toString());
		}
		return vo;
	}
	

	//°­ÁÂ¸ñ·Ï
	public JSONObject list(SqlVO vo) {
		JSONObject object=new JSONObject();
		try {
			String sql="call list('cou',?,?,?,?,?,?)";
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
				obj.put("lcode", rs.getString("lcode"));
				obj.put("lname", rs.getString("lname"));
				obj.put("hours", rs.getString("hours"));
				obj.put("instructor", rs.getString("instructor"));
				obj.put("capacity", rs.getString("capacity"));
				obj.put("persons", rs.getString("persons"));
				obj.put("pname", rs.getString("pname"));
				obj.put("room", rs.getString("room"));
				obj.put("dept", rs.getString("dept"));

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
			System.out.println("°­ÁÂ¸ñ·Ï:" + e.toString());
		}
		return object;
	}
}
