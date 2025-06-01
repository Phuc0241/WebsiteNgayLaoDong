$(document).ready(function () {
    // Auto-hide alerts
    setTimeout(function () {
        $('.alert').fadeOut(500, function () { $(this).remove(); });
    }, 3000);

    // Form validation
    $('.needs-validation').on('submit', function (event) {
        if (!this.checkValidity()) {
            event.preventDefault();
            event.stopPropagation();
        }
        $(this).addClass('was-validated');
    });

    // SĐT validation with AJAX
    $('#addSDT, #editSDT').on('input', function () {
        const sdt = $(this).val();
        const feedback = $(this).next('.invalid-feedback');
        const mssv = $('#editMSSV').val() || 0;

        if (!/^\d{10}$/.test(sdt)) {
            $(this).addClass('is-invalid');
            feedback.text('SĐT phải có đúng 10 chữ số.');
            return;
        }

        $.ajax({
            url: '/Admin/QuanLySinhVien/CheckSDT',
            type: 'POST',
            data: { sdt: sdt, mssv: mssv },
            success: function (response) {
                if (response.exists) {
                    $(this).addClass('is-invalid');
                    feedback.text('SĐT đã được sử dụng.');
                } else {
                    $(this).removeClass('is-invalid').addClass('is-valid');
                    feedback.text('SĐT hợp lệ.');
                }
            }.bind(this),
            error: function () {
                $(this).addClass('is-invalid');
                feedback.text('Lỗi kiểm tra SĐT.');
            }.bind(this)
        });
    });

    // File validation
    $('input[type="file"]').on('change', function () {
        const file = this.files[0];
        const allowedTypes = ['image/jpeg', 'image/png'];
        const maxSize = 5 * 1024 * 1024; // 5MB
        const feedback = $(this).next('.invalid-feedback');
        if (file) {
            if (!allowedTypes.includes(file.type)) {
                $(this).addClass('is-invalid');
                feedback.text('Chỉ chấp nhận file .jpg hoặc .png.');
                $(this).val('');
            } else if (file.size > maxSize) {
                $(this).addClass('is-invalid');
                feedback.text('File không được lớn hơn 5MB.');
                $(this).val('');
            } else {
                $(this).removeClass('is-invalid').addClass('is-valid');
                feedback.text('');
            }
        }
    });
});

// View details
function viewDetails(id) {
    const row = $(`#sinhVienTable tr[data-id="${id}"]`);
    $('#detailMSSV').text(row.find('[data-mssv]').text());
    $('#detailHoten').text(row.find('[data-hoten]').text());
    $('#detailGioiTinh').text(row.find('[data-gioitinh]').text());
    $('#detailQueQuan').text(row.find('[data-quequan]').text());
    $('#detailSDT').text(row.find('[data-sdt]').text());
    $('#detailLop').text(row.find('[data-lop]').text());
    $('#detailKhoa').text(row.find('[data-khoa]').text());
    $('#detailNgaySinh').text(row.data('ngaysinh') || '0');
    const anhSrc = row.find('[data-anh]').attr('data-anh');
    $('#detailAnh').html(anhSrc ? `<img src="/Uploads/${anhSrc}" style="width: 150px; height: auto; border-radius: 5px;" />` : 'Chưa có ảnh');
    new bootstrap.Modal(document.getElementById('chiTietSinhVienModal')).show();
}

// Fill edit form
function fillEditForm(id) {
    const row = $(`#sinhVienTable tr[data-id="${id}"]`);
    $('#editMSSV').val(row.find('[data-mssv]').text());
    $('#editHoten').val(row.find('[data-hoten]').text());
    $('#editGioiTinh').val(row.find('[data-gioitinh]').text() === 'Chưa xác định' ? '' : row.find('[data-gioitinh]').text());
    $('#editQueQuan').val(row.find('[data-quequan]').text() === 'Chưa xác định' ? '' : row.find('[data-quequan]').text());
    $('#editSDT').val(row.find('[data-sdt]').text() === 'Chưa xác định' ? '' : row.find('[data-sdt]').text());
    $('#editLopId').val(row.data('lop-id'));
    const ngaySinh = row.data('ngaysinh');
    if (ngaySinh && ngaySinh.match(/^\d{2}-\d{2}-\d{4}$/)) {
        const [day, month, year] = ngaySinh.split('-');
        $('#editNgaySinh').val(`${year}-${month}-${day}`);
    }
    new bootstrap.Modal(document.getElementById('suaSinhVienModal')).show();
}

// Set delete id
function setDeleteId(id) {
    $('#deleteMSSV').val(id);
}

// Export to Excel
window.exportToExcel = async function () {
    try {
        // Lấy tất cả các dòng (kể cả đang bị ẩn)
        const allRows = Array.from(document.querySelectorAll("#sinhVienTable tbody tr"));

        const headers = Array.from(document.querySelectorAll("#sinhVienTable thead th"))
            .map(th => th.textContent.trim())
            .filter((_, index) => index !== 9); // Loại bỏ cột "Tác Vụ"

        const data = allRows.map(row => {
            return Array.from(row.children)
                .filter((_, index) => index !== 9) // Loại bỏ cột "Tác Vụ"
                .map(cell => {
                    // Xử lý cột Ảnh: chỉ lấy tên file từ src nếu có
                    if (cell.querySelector('img')) {
                        const src = cell.querySelector('img').getAttribute('src');
                        return src ? src.split('/').pop() : 'Chưa có ảnh';
                    }
                    return cell.textContent.trim();
                });
        });

        const sheetData = [headers, ...data];

        const ws = XLSX.utils.aoa_to_sheet(sheetData);
        const wb = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(wb, ws, "DanhSachSinhVien");

        const wbout = XLSX.write(wb, { bookType: 'xlsx', type: 'array' });
        const blob = new Blob([wbout], { type: 'application/octet-stream' });

        if (window.showSaveFilePicker) {
            const handle = await window.showSaveFilePicker({
                suggestedName: 'DanhSachSinhVien.xlsx',
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
            saveAs(blob, 'DanhSachSinhVien.xlsx');
        }

        // Thông báo thành công
        const notificationContainer = document.createElement('div');
        notificationContainer.className = 'alert alert-success';
        notificationContainer.style.cssText = 'text-align: center; margin-bottom: 10px;';
        notificationContainer.textContent = 'Đã tải file Excel thành công!';
        document.querySelector('h2').insertAdjacentElement('afterend', notificationContainer);

        setTimeout(() => {
            notificationContainer.style.transition = 'opacity 0.5s ease';
            notificationContainer.style.opacity = '0';
            setTimeout(() => notificationContainer.remove(), 500);
        }, 3000);

    } catch (error) {
        console.error('Lỗi khi xuất file Excel:', error);
        const errorContainer = document.createElement('div');
        errorContainer.className = 'alert alert-danger';
        errorContainer.style.cssText = 'text-align: center; margin-bottom: 10px;';
        errorContainer.textContent = 'Đã ngắt xuất file';
        document.querySelector('h2').insertAdjacentElement('afterend', errorContainer);

        setTimeout(() => {
            errorContainer.style.transition = 'opacity 0.5s ease';
            errorContainer.style.opacity = '0';
            setTimeout(() => errorContainer.remove(), 500);
        }, 3000);
    }
};