$(document).ready(function () {
    const ROWS_PER_PAGE = 5;
    let currentPage = 1;
    let allRows = $('#duyetTable tbody tr');

    // Initialize pagination
    function initializePagination(filteredRows = allRows) {
        const tbody = $('#duyetTable tbody');
        const pagination = $('#pagination');
        const totalPages = Math.ceil(filteredRows.length / ROWS_PER_PAGE);

        pagination.empty();
        if (totalPages > 1) {
            pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="prev"><</a></li>');
            for (let i = 1; i <= totalPages; i++) {
                pagination.append(`<li class="page-item ${i === currentPage ? 'active' : ''}">
                    <a class="page-link" href="#" data-page="${i}">${i}</a></li>`);
            }
            pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="next">></a></li>');
        }

        displayRows(currentPage, filteredRows);

        pagination.find('.page-link').off('click').on('click', function (e) {
            e.preventDefault();
            const page = $(this).data('page');
            if (page === 'prev' && currentPage > 1) {
                currentPage--;
            } else if (page === 'next' && currentPage < totalPages) {
                currentPage++;
            } else if (!isNaN(page)) {
                currentPage = parseInt(page);
            }
            displayRows(currentPage, filteredRows);
            initializePagination(filteredRows);
        });
    }

    // Display rows for the current page
    function displayRows(page, rows) {
        const start = (page - 1) * ROWS_PER_PAGE;
        const end = start + ROWS_PER_PAGE;
        allRows.hide();
        rows.slice(start, end).show();
    }

    // Apply filters and search
    function applyFilters() {
        const searchTerm = $('#searchInput').val().toLowerCase();
        const filterLoai = $('#filterLoai').val();
        const filterTrangThai = $('#filterTrangThai').val();

        const filteredRows = allRows.filter(function () {
            const row = $(this);
            const dot = row.data('dot') ? row.data('dot').toLowerCase() : '';
            const ngay = row.data('ngay') ? row.data('ngay').toLowerCase() : '';
            const loai = row.data('loai') ? row.data('loai').toLowerCase() : '';
            const trangThai = row.data('trang-thai') ? row.data('trang-thai').toLowerCase() : '';

            const matchesSearch = !searchTerm ||
                dot.includes(searchTerm) ||
                ngay.includes(searchTerm) ||
                loai.includes(searchTerm);

            const matchesLoai = !filterLoai || loai === filterLoai.toLowerCase();
            const matchesTrangThai = !filterTrangThai || trangThai === filterTrangThai.toLowerCase();

            return matchesSearch && matchesLoai && matchesTrangThai;
        });

        currentPage = 1; // Reset to first page
        initializePagination(filteredRows);

        if (filteredRows.length === 0) {
            $('#duyetTable tbody').html('<tr><td colspan="7" class="text-center">Không tìm thấy kết quả.</td></tr>');
        }
    }

    // Show alert
    function showAlert(message, type = 'success') {
        const alertDiv = `<div class="alert alert-${type} alert-dismissible fade show" role="alert">
            <strong>${type === 'success' ? '✔️' : '❌'}</strong> ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>`;
        $('.container').prepend(alertDiv);
        setTimeout(() => $('.alert').alert('close'), 3000);
    }

    // Hàm xuất file Excel tổng quát
    window.exportToExcel = async function (tableId, fileName = 'Export.xlsx', sheetName = 'Sheet1', excludeLastColumn = false) {
        try {
            const table = document.getElementById(tableId);
            if (!table) throw new Error(`Không tìm thấy bảng với ID: ${tableId}`);

            const headers = Array.from(table.querySelectorAll("thead th"))
                .filter((_, index, arr) => !excludeLastColumn || index !== arr.length - 1)
                .map(th => th.textContent.trim());

            const rows = Array.from(table.querySelectorAll("tbody tr"));
            const data = rows.map(row => {
                return Array.from(row.children)
                    .filter((_, index, arr) => !excludeLastColumn || index !== arr.length - 1)
                    .map(cell => cell.textContent.trim());
            });

            const sheetData = [headers, ...data];
            const ws = XLSX.utils.aoa_to_sheet(sheetData);
            const wb = XLSX.utils.book_new();
            XLSX.utils.book_append_sheet(wb, ws, sheetName);

            const wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'array' });
            const blob = new Blob([wbout], { type: 'application/octet-stream' });

            // Dùng API hiện đại nếu có
            if (window.showSaveFilePicker) {
                const handle = await window.showSaveFilePicker({
                    suggestedName: fileName,
                    types: [{
                        description: 'Excel Files',
                        accept: {
                            'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet': ['.xlsx']
                        }
                    }]
                });
                const writable = await handle.createWritable();
                await writable.write(blob);
                await writable.close();
            } else {
                // Fallback với FileSaver.js
                saveAs(blob, fileName);
            }

            showNotification('Đã tải file Excel thành công!', 'success');
        } catch (error) {
            console.error('Lỗi khi xuất Excel:', error);
            showNotification('Đã ngắt xuất file', 'danger');
        }
    };

    // Hàm hiển thị thông báo
    function showNotification(message, type = 'success') {
        const notification = document.createElement('div');
        notification.className = `alert alert-${type}`;
        notification.style.cssText = 'text-align: center; margin-bottom: 10px;';
        notification.textContent = message;

        document.querySelector('h2')?.insertAdjacentElement('afterend', notification);

        setTimeout(() => {
            notification.style.transition = 'opacity 0.5s ease';
            notification.style.opacity = '0';
            setTimeout(() => notification.remove(), 500);
        }, 3000);
    }
    // Initialize pagination
    if (allRows.length > 0) {
        initializePagination();
    }

    // Bind filter and search events
    $('#searchInput').on('input', applyFilters);
    $('#filterLoai, #filterTrangThai').on('change', applyFilters);

    // Chi Tiết button
    $(document).on('click', '.btn-chi-tiet', function () {
        const id = $(this).data('id');
        const row = $(`tr[data-id="${id}"]`);
        $('#detailDotLaoDong').text(row.data('dot') || 'Chưa xác định');
        $('#detailNgayLaoDong').text(row.data('ngay') || 'Chưa xác định');
        $('#detailSoSinhVien').text(`${row.data('so-sinh-vien')}/${row.data('so-luong')}`);
        $('#detailLoaiLaoDong').text(row.data('loai') || 'Chưa xác định');
        $('#detailTrangThai').text(row.data('trang-thai') || 'Chưa xác định');
        new bootstrap.Modal(document.getElementById('chiTietModal')).show();
    });

    // Duyệt button
    $(document).on('click', '.btn-duyet', function () {
        const id = $(this).data('id');
        const row = $(`tr[data-id="${id}"]`);
        const soSinhVien = parseInt(row.data('so-sinh-vien'));
        const soLuongSinhVien = parseInt(row.data('so-luong'));

        if (soSinhVien > soLuongSinhVien) {
            showAlert('Số sinh viên đăng ký vượt quá giới hạn cho phép!', 'danger');
            return;
        }

        $.ajax({
            url: '/Admin/AdminTask/Duyet',
            type: 'POST',
            data: {
                id: id,
                __RequestVerificationToken: $('#khongDuyetModal input[name="__RequestVerificationToken"]').val() || $('input[name="__RequestVerificationToken"]').val()
            },
            success: function (response) {
                if (response.success) {
                    row.find('.badge').removeClass('bg-secondary').addClass('bg-success').text('Đã duyệt');
                    row.find('.btn-duyet').replaceWith('<button class="btn btn-warning btn-sm btn-khong-duyet" data-id="' + id + '" data-bs-toggle="modal" data-bs-target="#khongDuyetModal"><i class="fas fa-times"></i> Không duyệt</button>');
                    row.data('trang-thai', 'Đã duyệt');
                    showAlert('Duyệt đợt lao động thành công!', 'success');
                    applyFilters();
                } else {
                    showAlert(response.message || 'Lỗi khi duyệt.', 'danger');
                }
            },
            error: function (xhr, status, error) {
                console.error('Duyệt AJAX Error:', { status, error, response: xhr.responseText });
                showAlert(`Lỗi khi duyệt: ${xhr.statusText || 'Không xác định'}`, 'danger');
            }
        });
    });

    // Không Duyệt button - Set ID for confirmation
    $(document).on('show.bs.modal', '#khongDuyetModal', function (event) {
        const button = $(event.relatedTarget);
        const id = button.data('id');
        $(this).data('dot-id', id);
    });

    // Confirm Không Duyệt
    $(document).on('click', '#confirmKhongDuyet', function () {
        const modal = $('#khongDuyetModal');
        const id = modal.data('dot-id');
        const row = $(`tr[data-id="${id}"]`);

        $.ajax({
            url: '/Admin/AdminTask/KhongDuyet',
            type: 'POST',
            data: {
                id: id,
                __RequestVerificationToken: modal.find('input[name="__RequestVerificationToken"]').val()
            },
            success: function (response) {
                if (response.success) {
                    row.find('.badge').removeClass('bg-success').addClass('bg-secondary').text('Chưa duyệt');
                    row.find('.btn-khong-duyet').replaceWith('<button class="btn btn-success btn-sm btn-duyet" data-id="' + id + '"><i class="fas fa-check"></i> Duyệt</button>');
                    row.data('trang-thai', 'Chưa duyệt');
                    showAlert('Hủy duyệt thành công!', 'success');
                    applyFilters();
                } else {
                    showAlert(response.message || 'Lỗi khi hủy duyệt.', 'danger');
                }
            },
            error: function (xhr, status, error) {
                console.error('Không Duyệt AJAX Error:', { status, error, response: xhr.responseText });
                showAlert(`Lỗi khi hủy duyệt: ${xhr.statusText || 'Không xác định'}`, 'danger');
            },
            complete: function () {
                modal.modal('hide');
            }
        });
    });

    // Danh Sách Sinh Viên
    $(document).on('click', '.btn-danh-sach', function () {
        const id = $(this).data('id');
        const tbody = $('#sinhVienTableBody');
        tbody.html('<tr><td colspan="5" class="text-center"><i class="fas fa-spinner fa-spin"></i> Đang tải...</td></tr>');

        $.get('/Admin/AdminTask/DanhSachSinhVien', { id: id }, function (data) {
            tbody.empty();
            if (data && data.length > 0) {
                data.forEach((sv, index) => {
                    tbody.append(`
                        <tr>
                            <td>${index + 1}</td>
                            <td>${sv.MSSV || 'Chưa xác định'}</td>
                            <td>${sv.TenSinhVien || 'Chưa xác định'}</td>
                            <td>${sv.Lop || 'Chưa xác định'}</td>
                            <td>${sv.Khoa || 'Chưa xác định'}</td>
                        </tr>
                    `);
                });
            } else {
                tbody.append('<tr><td colspan="5" class="text-center">Không có sinh viên đăng ký.</td></tr>');
            }
        }).fail(function (xhr, status, error) {
            console.error('Danh Sách Sinh Viên AJAX Error:', { status, error, response: xhr.responseText });
            tbody.html('<tr><td colspan="5" class="text-danger text-center">Lỗi khi tải danh sách.</td></tr>');
            showAlert(`Lỗi khi tải danh sách sinh viên: ${xhr.statusText || 'Không xác định'}`, 'danger');
        });
    });
});