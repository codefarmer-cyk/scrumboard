package com.voice.ece.cgc.ericsson.util;

import java.awt.Color;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.ConditionalFormattingRule;
import org.apache.poi.ss.usermodel.CreationHelper;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.ss.usermodel.PatternFormatting;
import org.apache.poi.ss.usermodel.SheetConditionalFormatting;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.apache.poi.ss.util.RegionUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFColor;
import org.apache.poi.xssf.usermodel.XSSFDataValidation;
import org.apache.poi.xssf.usermodel.XSSFDataValidationConstraint;
import org.apache.poi.xssf.usermodel.XSSFDataValidationHelper;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import com.voice.ece.cgc.ericsson.pojo.Member;
import com.voice.ece.cgc.ericsson.pojo.Release;
import com.voice.ece.cgc.ericsson.pojo.Sprint;
import com.voice.ece.cgc.ericsson.pojo.Task;
import com.voice.ece.cgc.ericsson.pojo.UserStory;

public class ScrumboardWorkBook {

	public static File exportTaskList(Release release, String filePath) {
		File file = new File(filePath);
		FileOutputStream fileOut = null;
		try {
			fileOut = new FileOutputStream(file);
			XSSFWorkbook wb = new XSSFWorkbook();
			for (Sprint sprint : release.getSprints()) {

				Map<UserStory, List<Task>> usTasks = new HashMap();
				for (Task task : sprint.getTaskSet()) {
					List<Task> taskList;
					if (!usTasks.containsKey(task.getUserStory())) {
						taskList = new LinkedList<Task>();
						taskList.add(task);
					} else {
						taskList = usTasks.get(task.getUserStory());
						taskList.add(task);
					}
					usTasks.put(task.getUserStory(), taskList);
				}

				XSSFCellStyle style = createNewStyle(wb, "title");
				XSSFSheet sheet = wb.createSheet("Sprint #" + sprint.getNumber());
				createConditionalFormat(sheet, sprint.getTaskSet().size());

				sheet.setColumnWidth(0, 18 * 256 + 200);
				sheet.setColumnWidth(1, 9 * 256 + 200);
				sheet.setColumnWidth(2, (int) (73.57 * 256 + 200));
				sheet.setColumnWidth(3, (int) (11.29 * 256 + 200));
				sheet.setColumnWidth(4, (int) (8.57 * 256 + 200));
				sheet.setColumnWidth(5, (int) (64.57 * 256 + 200));
				sheet.setColumnWidth(6, (int) (51.29 * 256 + 200));
				sheet.setAutoFilter(CellRangeAddress.valueOf("A1:G" + sprint.getTaskSet().size()));

				XSSFDataValidationHelper dvHelper = new XSSFDataValidationHelper(sheet);
				XSSFDataValidationConstraint dvConstraint = (XSSFDataValidationConstraint) dvHelper
						.createExplicitListConstraint(new String[] { "TODO", "ONGOING", "REVIEW", "DONE", "FOLLOWUP",
								"PENDING", "POSTPONE" });
				CellRangeAddressList statusList = new CellRangeAddressList(1, sprint.getTaskSet().size(), 3, 3);
				XSSFDataValidation validation = (XSSFDataValidation) dvHelper.createValidation(dvConstraint,
						statusList);
				validation.setShowErrorBox(true);
				sheet.addValidationData(validation);

				List<String> names = new ArrayList<String>();
				for (Member member : release.getTeam().getMemberSet()) {
					names.add(member.getName());
				}
				XSSFDataValidationConstraint dvConstraint2 = (XSSFDataValidationConstraint) dvHelper
						.createExplicitListConstraint(names.toArray(new String[] {}));
				CellRangeAddressList nameList = new CellRangeAddressList(1, sprint.getTaskSet().size(), 4, 4);
				XSSFDataValidation validation2 = (XSSFDataValidation) dvHelper.createValidation(dvConstraint2,
						nameList);
				validation.setShowErrorBox(true);
				sheet.addValidationData(validation2);

				XSSFRow titleRow = sheet.createRow(0);
				XSSFCell userStoryCell = titleRow.createCell(0);
				userStoryCell.setCellValue("User Story");
				userStoryCell.setCellStyle(style);
				XSSFCell noCell = titleRow.createCell(1);
				noCell.setCellValue("No.");
				noCell.setCellStyle(style);
				XSSFCell taskCell = titleRow.createCell(2);
				taskCell.setCellValue("Task");
				taskCell.setCellStyle(style);
				XSSFCell statusCell = titleRow.createCell(3);
				statusCell.setCellValue("Status");
				statusCell.setCellStyle(style);
				XSSFCell ownerCell = titleRow.createCell(4);
				ownerCell.setCellValue("Owner");
				ownerCell.setCellStyle(style);
				XSSFCell detailCell = titleRow.createCell(5);
				detailCell.setCellValue("Detail");
				detailCell.setCellStyle(style);
				XSSFCell followUpCell = titleRow.createCell(6);
				followUpCell.setCellValue("Follow Up");
				followUpCell.setCellStyle(style);
				int rowIndex = 1;
				for (Map.Entry<UserStory, List<Task>> entry : usTasks.entrySet()) {
					XSSFCellStyle rowStyle = wb.createCellStyle();
					rowStyle.setWrapText(true);

					XSSFRow row = sheet.createRow(rowIndex);
					row.setRowStyle(rowStyle);
					XSSFCell cell0 = row.createCell(0);
					XSSFCellStyle usStyle = null;
					if (entry.getKey() != null) {
						usStyle = createNewStyle(wb, entry.getKey().getType());
						cell0.setCellValue(entry.getKey().getDescription());
					}
					cell0.setCellStyle(usStyle);
					if (entry.getValue().size() > 1) {
						CellRangeAddress region = CellRangeAddress
								.valueOf("A" + (rowIndex + 1) + ":A" + (entry.getValue().size() + rowIndex));
						sheet.addMergedRegion(region);
						final short borderMediumDashed = CellStyle.BORDER_THIN;
						RegionUtil.setBorderBottom(borderMediumDashed, region, sheet, wb);
						RegionUtil.setBorderTop(borderMediumDashed, region, sheet, wb);
						RegionUtil.setBorderLeft(borderMediumDashed, region, sheet, wb);
						RegionUtil.setBorderRight(borderMediumDashed, region, sheet, wb);
					}
					for (Task task : entry.getValue()) {
						XSSFCellStyle taskStyle = createNewStyle(wb, task.getStatus());
						XSSFCell cell1 = row.createCell(1);
						if (task.getUserStory() != null) {
							cell1.setCellValue(task.getUserStory().getNumber());
						}
						XSSFCell cell2 = row.createCell(2);
						cell1.setCellStyle(usStyle);
						cell2.setCellValue(task.getDescription());
						cell2.setCellStyle(taskStyle);
						XSSFCell cell3 = row.createCell(3);
						cell3.setCellValue(task.getStatus());
						cell3.setCellStyle(taskStyle);
						XSSFCell cell4 = row.createCell(4);
						cell4.setCellStyle(taskStyle);
						if (task.getChargedMember() != null) {
							cell4.setCellValue(task.getChargedMember().getName());
						}
						XSSFCell cell5 = row.createCell(5);
						cell5.setCellValue(task.getDetails());
						cell5.setCellStyle(taskStyle);
						XSSFCell cell6 = row.createCell(6);
						cell6.setCellStyle(taskStyle);
						cell6.setCellValue(task.getFollowUp());
						row = sheet.createRow(++rowIndex);
					}
				}
			}
			wb.write(fileOut);
			fileOut.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return file;
	}

	private static XSSFCellStyle createNewStyle(XSSFWorkbook wb, String type) {
		XSSFCellStyle style = wb.createCellStyle();

		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		Font font = wb.createFont();
		font.setFontHeightInPoints((short) 11);
		font.setFontName("Calibri");
		style.setFont(font);
		style.setAlignment(CellStyle.ALIGN_GENERAL);
		style.setVerticalAlignment(CellStyle.VERTICAL_BOTTOM);
		style.setBorderBottom(CellStyle.BORDER_THIN);
		style.setBottomBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderLeft(CellStyle.BORDER_THIN);
		style.setLeftBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderRight(CellStyle.BORDER_THIN);
		style.setRightBorderColor(IndexedColors.BLACK.getIndex());
		style.setBorderTop(CellStyle.BORDER_THIN);
		style.setTopBorderColor(IndexedColors.BLACK.getIndex());
		style.setWrapText(true);
		if (type.equals("title")) {
			font.setColor(IndexedColors.DARK_BLUE.getIndex());
			style.setFillForegroundColor(new XSSFColor(new Color(255, 204, 153)));
		} else if (type.equals("UserStory")) {
			style.setFillForegroundColor(new XSSFColor(new Color(0, 176, 240)));
		} else if (type.equals("Artifact")) {
			style.setFillForegroundColor(new XSSFColor(new Color(112, 48, 160)));
		} else if (type.equals("Development")) {
			style.setFillForegroundColor(new XSSFColor(new Color(0, 176, 80)));
		} else if (type.equals("Improvement")) {
			style.setFillForegroundColor(new XSSFColor(new Color(226, 107, 10)));
		} else if (type.equals("Performance")) {
			style.setFillForegroundColor(new XSSFColor(new Color(255, 192, 0)));
		}

		style.setFillPattern(XSSFCellStyle.SOLID_FOREGROUND);
		return style;
	}

	private static void createConditionalFormat(XSSFSheet sheet, int rowNum) {
		SheetConditionalFormatting sheetCF = sheet.getSheetConditionalFormatting();
		String[] types = new String[] { "TODO", "ONGOING", "REVIEW", "DONE", "FOLLOWUP", "PENDING", "POSTPONE" };
		CellRangeAddress[] regions = { CellRangeAddress.valueOf("C2:G" + rowNum + 1) };

		for (String type : types) {
			ConditionalFormattingRule rule = sheetCF.createConditionalFormattingRule("$D2=\"" + type + "\"");
			PatternFormatting fill = rule.createPatternFormatting();
			if (type.equals("TODO")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(218, 150, 148)));
			} else if (type.equals("ONGOING")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(146, 205, 220)));
			} else if (type.equals("REVIEW")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(177, 160, 199)));
			} else if (type.equals("DONE")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(146, 208, 80)));
			} else if (type.equals("FOLLOWUP")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(210, 66, 152)));
			} else if (type.equals("PENDING")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(255, 255, 0)));
			} else if (type.equals("POSTPONE")) {
				fill.setFillBackgroundColor(new XSSFColor(new Color(247, 150, 70)));
			}
			fill.setFillPattern(PatternFormatting.SOLID_FOREGROUND);
			sheetCF.addConditionalFormatting(regions, rule);
		}
	}
}
