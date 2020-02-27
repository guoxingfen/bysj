package bysj.swzl.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bysj.swzl.constant.MesCode;
import bysj.swzl.mapper.StuInfoMapper;
import bysj.swzl.pojo.Message;
import bysj.swzl.pojo.StuInfo;
import bysj.swzl.service.StuInfoService;
@Service
public class StuInfoServiceImpl implements StuInfoService {

	@Autowired
	private StuInfoMapper stuInfoMapper;
	// �û�ע��
	@Override
	public Message register(StuInfo si) {
		Message ms=new Message();
		si.setStatus(1);
		stuInfoMapper.insertStuInfo(si);
		ms.setObj(si);
		return ms;
	}

	// �û���¼
	@Override
	public Message login(StuInfo si) {
        Message ms=new Message();
		StuInfo stuInfo=stuInfoMapper.getStuInfoToLogin(si);
		if(stuInfo!=null) {
			ms.setCode(MesCode.SUCCESS);
			ms.setMessage("��¼�ɹ���");
			ms.setObj(stuInfo);
		}else {
			ms.setCode(MesCode.FAIL);
			ms.setMessage("�������");
		}
		return ms;
	}

	// ��ѯ�û��Ƿ����
	@Override
	public Message queryStu(StuInfo si) {
		Message mes=new Message();
		StuInfo stuInfo=stuInfoMapper.getStuInfo(si);
		if(stuInfo!=null) {
			mes.setCode(MesCode.SUCCESS);
			mes.setObj(stuInfo);
			mes.setMessage("�û���ע�ᣡ");
		}else {
			mes.setCode(MesCode.FAIL);
			mes.setMessage("�û������ڣ�");
		}
		return mes;
	}

	// �û���������
	@Override
	public Message resetPwd(StuInfo si) {
		Message mes=new Message();
		StuInfo stuInfo=stuInfoMapper.getStuInfo(si);
		stuInfo.setPassword(si.getPassword());
		stuInfoMapper.resetPassWord(stuInfo);
		mes.setObj(stuInfo);
		return mes;
	}

	@Override
	public StuInfo getStuById(Integer id) {
		return stuInfoMapper.getStuInfoById(id);
	}

	@Override
	public void updateStuInfo(StuInfo si) {
		stuInfoMapper.updateStuInfo(si);
	}

	@Override
	public List<StuInfo> getAllStuInfo() {
		return stuInfoMapper.getAllStuInfo();
	}

	@Override
	public void changeStuStatus(Map<String, Object> map) {
		stuInfoMapper.changeStuStatus(map);
	}

	@Override
	public Integer getTotal(Map<String,Integer> status) {
		return stuInfoMapper.getTotal(status);
	}

	

}
