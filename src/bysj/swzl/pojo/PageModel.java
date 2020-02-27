package bysj.swzl.pojo;

import java.util.List;

// �ֲ�ģ��
public class PageModel<T> {

	// ��ǰҳ
	private Integer pageNumber;
	// ÿҳ��ʾ����
	private Integer pageSize;
	// �ܼ�¼��
	private Integer totalRecord;
	// �ܷ�ҳ��
	private Integer totalPage;
	// ��ҳ����
	private List<T> data;
	// ��ʼ����
	private Integer startIndex;
	
	public PageModel(Integer pageNumber,Integer pageSize,Integer totalRecord) {
		this.pageNumber=pageNumber;
		this.pageSize=pageSize;
		this.totalRecord=totalRecord;
		this.totalPage=(this.totalRecord+this.pageSize-1)/this.pageSize;
		this.startIndex=(this.pageNumber-1)*this.pageSize;
	}

	public Integer getPageNumber() {
		return pageNumber;
	}

	public void setPageNumber(Integer pageNumber) {
		this.pageNumber = pageNumber;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public Integer getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(Integer totalRecord) {
		this.totalRecord = totalRecord;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public List<T> getData() {
		return data;
	}

	public void setData(List<T> data) {
		this.data = data;
	}

	public Integer getStartIndex() {
		return startIndex;
	}

	public void setStartIndex(Integer startIndex) {
		this.startIndex = startIndex;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
