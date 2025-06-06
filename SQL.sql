USE [master]
GO
/****** Object:  Database [DB_QLNLD4ROLE]    Script Date: 6/1/2025 11:59:39 AM ******/
CREATE DATABASE [DB_QLNLD4ROLE3]
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DB_QLNLD4ROLE].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ARITHABORT OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET  MULTI_USER 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET QUERY_STORE = ON
GO
ALTER DATABASE [DB_QLNLD4ROLE3] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [DB_QLNLD4ROLE3]
GO
/****** Object:  Table [dbo].[Anh]    Script Date: 6/1/2025 11:59:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Anh](
	[anh_id] [int] IDENTITY(1,1) NOT NULL,
	[duongdan] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[anh_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DanhSachDiemDanh]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DanhSachDiemDanh](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[MSSV] [int] NOT NULL,
	[dot_id] [int] NOT NULL,
	[ma_diem_danh] [nvarchar](20) NULL,
	[thoi_gian] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Khoa]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khoa](
	[khoa_id] [int] NOT NULL,
	[ma_khoa] [nvarchar](10) NOT NULL,
	[ten_khoa] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[khoa_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Lop]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Lop](
	[lop_id] [int] NOT NULL,
	[ma_lop] [nvarchar](20) NOT NULL,
	[ten_lop] [nvarchar](255) NULL,
	[khoa_id] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[lop_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDangKy]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDangKy](
	[id] [int] NOT NULL,
	[MSSV] [int] NULL,
	[LaoDongTheoLop] [bit] NULL,
	[LaoDongCaNhan] [bit] NULL,
	[ThoiGian] [datetime] NULL,
	[DotLaoDongId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuDuyet]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuDuyet](
	[id] [int] NOT NULL,
	[Nguoiduyet] [int] NULL,
	[ThoiGian] [datetime] NULL,
	[PhieuDangKy] [int] NULL,
	[TrangThai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhieuXacNhanHoanThanh]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhieuXacNhanHoanThanh](
	[id] [int] NOT NULL,
	[MSSV] [int] NULL,
	[phieuduyet] [int] NULL,
	[NguoiXacNhan] [int] NULL,
	[ThoiGian] [datetime] NULL,
	[ngay_xac_nhan] [datetime] NULL,
	[trang_thai] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QuanLy]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QuanLy](
	[quanly_id] [int] NOT NULL,
	[hoten] [nvarchar](255) NULL,
	[gioitinh] [bit] NULL,
	[diachi] [nvarchar](255) NULL,
	[SDT] [char](15) NULL,
	[taikhoan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[quanly_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SinhVien]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SinhVien](
	[MSSV] [int] NOT NULL,
	[hoten] [nvarchar](255) NOT NULL,
	[ngaysinh] [date] NULL,
	[quequan] [nvarchar](255) NULL,
	[gioitinh] [nvarchar](10) NULL,
	[taikhoan] [int] NULL,
	[SDT] [char](15) NULL,
	[lop_id] [int] NULL,
	[anh_id] [int] NULL,
	[email] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[MSSV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SoNgayLaoDong]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SoNgayLaoDong](
	[id] [int] NOT NULL,
	[MSSV] [int] NULL,
	[TongSoNgay] [int] NULL,
	[Ma_phieu_xac_nhan] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaiKhoan](
	[taikhoan_id] [int] IDENTITY(1,1) NOT NULL,
	[username] [nvarchar](255) NULL,
	[password] [nvarchar](255) NULL,
	[email] [nvarchar](255) NULL,
	[role_id] [int] NULL,
	[reset_token] [nvarchar](255) NULL,
	[reset_token_expiry] [datetime] NULL,
	[deleted_at] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[taikhoan_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaoDotNgayLaoDong]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaoDotNgayLaoDong](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TenDotLaoDong] [nvarchar](255) NULL,
	[MoTa] [nvarchar](500) NULL,
	[NgayBatDau] [datetime] NULL,
	[NgayKetThuc] [datetime] NULL,
	[NgayTao] [datetime] NULL,
	[NgayCapNhat] [datetime] NULL,
	[NguoiTao] [int] NULL,
	[DotLaoDong] [nvarchar](255) NULL,
	[Buoi] [nvarchar](50) NULL,
	[LoaiLaoDong] [nvarchar](100) NULL,
	[GiaTri] [int] NULL,
	[ThoiGian] [nvarchar](50) NULL,
	[NgayLaoDong] [date] NULL,
	[KhuVuc] [nvarchar](100) NULL,
	[Ngayxoa] [datetime] NULL,
	[SoLuongSinhVien] [int] NULL,
	[TrangThaiDuyet] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VaiTro]    Script Date: 6/1/2025 11:59:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VaiTro](
	[vaitro_id] [int] IDENTITY(1,1) NOT NULL,
	[vaitro] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[vaitro_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Anh] ON 

INSERT [dbo].[Anh] ([anh_id], [duongdan]) VALUES (1, N'D:\BAO_CAO\MVC\avatar\man.png')
INSERT [dbo].[Anh] ([anh_id], [duongdan]) VALUES (2, N'D:\BAO_CAO\MVC\avatar\man1.png')
INSERT [dbo].[Anh] ([anh_id], [duongdan]) VALUES (3, N'D:\BAO_CAO\MVC\avatar\man2.png')
INSERT [dbo].[Anh] ([anh_id], [duongdan]) VALUES (4, N'D:\BAO_CAO\MVC\avatar\girl.png')
INSERT [dbo].[Anh] ([anh_id], [duongdan]) VALUES (5, N'D:\BAO_CAO\MVC\avatar\woman.png')
SET IDENTITY_INSERT [dbo].[Anh] OFF
GO
INSERT [dbo].[Khoa] ([khoa_id], [ma_khoa], [ten_khoa]) VALUES (1, N'CNTT', N'Công nghệ và kỹ thuật')
INSERT [dbo].[Khoa] ([khoa_id], [ma_khoa], [ten_khoa]) VALUES (2, N'QTKD', N'Quản trị kinh doanh')
INSERT [dbo].[Khoa] ([khoa_id], [ma_khoa], [ten_khoa]) VALUES (3, N'SPTO', N'Sư phạm Toán học')
INSERT [dbo].[Khoa] ([khoa_id], [ma_khoa], [ten_khoa]) VALUES (4, N'DLNH', N'Du lịch - Nhà hàng')
INSERT [dbo].[Khoa] ([khoa_id], [ma_khoa], [ten_khoa]) VALUES (5, N'NNAN', N'Ngôn ngữ Anh')
GO
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (1, N'DHKTPM16A', N'Kỹ thuật phần mềm 16A', 1)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (2, N'DHBQTKD01', N'Quản trị kinh doanh 01', 2)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (3, N'DHSPO2', N'Sư phạm Toán 02', 3)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (4, N'DHDLNH1', N'Du lịch - Nhà hàng 01', 4)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (5, N'DHNN01', N'Ngôn ngữ Anh 01', 5)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (6, N'ĐHCNTT22A', N'Công nghệ thông tin 22A', 1)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (7, N'ĐHCNTT22B', N'Công nghệ thông tin 22B', 1)
INSERT [dbo].[Lop] ([lop_id], [ma_lop], [ten_lop], [khoa_id]) VALUES (8, N'ĐHCNTT22C', N'Công nghệ thông tin 22C', 1)
GO
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (1, 22410011, 1, 0, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (2, 22410012, 1, 0, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 2)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (3, 22410011, 1, 0, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 3)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (4, 22410004, 0, 1, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 4)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (5, 22410005, 0, 1, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 5)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (6, 22410012, 1, 0, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 6)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (7, 22410007, 0, 1, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 7)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (8, 22410011, 1, 0, CAST(N'2025-05-22T22:29:45.623' AS DateTime), 8)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (9, 22410003, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (10, 22410004, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (11, 22410005, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (12, 22410006, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (13, 22410007, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (14, 22410008, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (15, 22410009, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (16, 22410010, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (17, 22410011, NULL, NULL, NULL, 1)
INSERT [dbo].[PhieuDangKy] ([id], [MSSV], [LaoDongTheoLop], [LaoDongCaNhan], [ThoiGian], [DotLaoDongId]) VALUES (18, 22410012, NULL, NULL, NULL, 1)
GO
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (1, 1, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 1, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (2, 2, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 2, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (3, 1, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 3, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (4, 2, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 4, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (5, 2, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 5, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (6, 1, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 6, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (7, 1, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 7, N'Ðã duy?t')
INSERT [dbo].[PhieuDuyet] ([id], [Nguoiduyet], [ThoiGian], [PhieuDangKy], [TrangThai]) VALUES (8, 2, CAST(N'2025-05-22T22:29:45.627' AS DateTime), 8, N'Ðã duy?t')
GO
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (1, 22410011, 1, 1, CAST(N'2025-05-22T22:29:45.630' AS DateTime), CAST(N'2025-06-01T10:32:47.850' AS DateTime), N'Hoàn Thành')
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (2, 22410012, 2, 2, CAST(N'2025-05-22T22:29:45.630' AS DateTime), CAST(N'2025-06-01T10:21:20.647' AS DateTime), N'Chờ Xác Nhận')
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (3, 22410011, 3, 1, CAST(N'2025-05-22T22:29:45.630' AS DateTime), CAST(N'2025-06-01T10:24:25.127' AS DateTime), N'Chờ Xác Nhận')
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (4, 22410004, 4, 2, CAST(N'2025-05-22T22:29:45.630' AS DateTime), CAST(N'2025-06-01T10:24:31.813' AS DateTime), N'Chờ Duyệt')
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (5, 22410005, 5, 2, CAST(N'2025-05-22T22:29:45.630' AS DateTime), CAST(N'2025-06-01T10:32:22.443' AS DateTime), N'Chờ Duyệt')
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (6, 22410012, 6, 1, CAST(N'2025-05-22T22:29:45.630' AS DateTime), NULL, NULL)
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (7, 22410007, 7, 1, CAST(N'2025-05-22T22:29:45.630' AS DateTime), NULL, NULL)
INSERT [dbo].[PhieuXacNhanHoanThanh] ([id], [MSSV], [phieuduyet], [NguoiXacNhan], [ThoiGian], [ngay_xac_nhan], [trang_thai]) VALUES (8, 22410011, 8, 2, CAST(N'2025-05-22T22:29:45.630' AS DateTime), NULL, NULL)
GO
INSERT [dbo].[QuanLy] ([quanly_id], [hoten], [gioitinh], [diachi], [SDT], [taikhoan]) VALUES (1, N'Nguyễn Văn Quảng', 1, N'Hà Nội', N'0901000001     ', 2)
INSERT [dbo].[QuanLy] ([quanly_id], [hoten], [gioitinh], [diachi], [SDT], [taikhoan]) VALUES (2, N'Trần Thị Lý', 0, N'Hồ Chí Minh', N'0901000002     ', 3)
GO
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410001, N'Nguyễn Văn An', NULL, N'Tiền Giang', N'Nữ', 4, N'01234567812    ', 7, 1, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410002, N'Trần Thị Bảo Trân', NULL, N'Cà Mau', N'Nữ', 5, N'0345678912     ', 7, 2, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410003, N'Lê Văn Chí', CAST(N'2002-03-03' AS Date), N'Bạc Liêu', N'Nam', 6, N'0987654321     ', 7, 3, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410004, N'Phạm Thị Dung', CAST(N'2002-04-04' AS Date), N'Vĩnh Long', N'Nữ', 7, N'0912345678     ', 8, 4, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410005, N'Vũ Văn Tâm', NULL, NULL, NULL, 8, NULL, 6, 5, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410006, N'Đỗ Thị Mơ', CAST(N'2004-09-20' AS Date), N'Đồng Tháp', NULL, 9, N'0987653412     ', 6, 1, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410007, N'Ngô Văn Trung', CAST(N'2002-07-07' AS Date), N'Nghệ An', NULL, 10, N'0987654321     ', 1, 2, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410008, N'Hồ Thị Hà', CAST(N'2002-08-08' AS Date), N'Quảng Ngãi', NULL, 11, N'0911111108     ', 1, 3, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410009, N'Tạ Minh Trí', CAST(N'2002-09-09' AS Date), N'Huế', NULL, 12, N'0911111109     ', 1, 4, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410010, N'Lý Thị Kha', CAST(N'2002-10-10' AS Date), N'Bình Định', NULL, 13, N'0911111110     ', 1, 5, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410011, N'Nguyễn Văn Trưởng', CAST(N'2002-11-11' AS Date), N'Cà Mau', NULL, 14, N'0911111111     ', 1, 1, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410012, N'Trần Thị Liên', CAST(N'2002-12-12' AS Date), N'Vĩnh Long', NULL, 15, N'0911111112     ', 1, 2, NULL)
INSERT [dbo].[SinhVien] ([MSSV], [hoten], [ngaysinh], [quequan], [gioitinh], [taikhoan], [SDT], [lop_id], [anh_id], [email]) VALUES (22410131, N'Nguyễn Văn An', CAST(N'2004-01-01' AS Date), N'Tiền Giang', N'Nam', NULL, N'0123456781     ', 6, NULL, N'admin@dthu.edu.vn')
GO
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (1, 22410011, 18, 1)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (2, 22410012, 18, 2)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (3, 22410011, 18, 3)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (4, 22410004, 18, 4)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (5, 22410005, 18, 5)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (6, 22410012, 2, 6)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (7, 22410007, 1, 7)
INSERT [dbo].[SoNgayLaoDong] ([id], [MSSV], [TongSoNgay], [Ma_phieu_xac_nhan]) VALUES (8, 22410011, 2, 8)
GO
SET IDENTITY_INSERT [dbo].[TaiKhoan] ON 

INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (1, N'admin', N'adminpass', N'admin@dthu.edu.vn', 1, N'75b1312a-f2b8-4e7c-8b5d-0b7232725a5e', CAST(N'2025-05-29T21:56:06.613' AS DateTime), NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (2, N'quanly1', N'Hieu123@', N'quanly1@dthu.edu.vn', 2, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (3, N'quanly2', N'qlpass2', N'quanly2@dthu.edu.vn', 2, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (4, N'0022410001', N'dthu10012003', N'0022410001@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (5, N'0022410002', N'dthu10012003', N'0022410002@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (6, N'0022410003', N'dthu10012003', N'0022410003@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (7, N'0022410004', N'dthu10012003', N'0022410004@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (8, N'0022410005', N'dthu10012003', N'0022410005@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (9, N'0022410006', N'dthu10012003', N'0022410006@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (10, N'0022410007', N'dthu10012003', N'0022410007@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (11, N'0022410008', N'dthu10012003', N'0022410008@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (12, N'0022410009', N'dthu10012003', N'0022410009@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (13, N'0022410010', N'dthu10012003', N'0022410010@student.dthu.edu.vn', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (14, N'0022410011', N'dthu10012003', N'0022410011@student.dthu.edu.vn', 4, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (15, N'0022410012', N'dthu10012003', N'0022410012@student.dthu.edu.vn', 4, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (16, N'HuynhTienHieu', N'Hieu123@', N'huynhtienhieubasao12@gmail.com', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (17, N'HTH12', N'Hieu123', N'huynhtienhieubasao13@gmail.com', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (18, N'HTH12', N'abc@123', N'huynhtienhieubasao@gmail.com', 1, NULL, NULL, CAST(N'2025-05-27T14:20:37.660' AS DateTime))
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (19, N'HTH', N'abc@123', N'huynhtienhieubasao14@gmail.com', 1, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (20, N'quanly12', N'abc@123', N'admin01@example.com', 2, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (21, N'HTH', N'abc@123', N'huynhtienhieubasao@gmail.com', 3, NULL, NULL, NULL)
INSERT [dbo].[TaiKhoan] ([taikhoan_id], [username], [password], [email], [role_id], [reset_token], [reset_token_expiry], [deleted_at]) VALUES (22, N'HTH', N'Hieu123', N'huynhtienhieubasao17@gmail.com', 3, NULL, NULL, CAST(N'2025-05-31T10:46:29.623' AS DateTime))
SET IDENTITY_INSERT [dbo].[TaiKhoan] OFF
GO
SET IDENTITY_INSERT [dbo].[TaoDotNgayLaoDong] ON 

INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (1, N'Dợt 1 - Vệ sinh lớp học', N'Dọn khu B', CAST(N'2025-05-01T00:00:00.000' AS DateTime), CAST(N'2025-05-03T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-31T01:23:08.610' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Lớp', 1, N'7h30 đến 8h30', CAST(N'2025-01-05' AS Date), N'Tòa B', NULL, 50, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (2, N'Dợt 2 - Trồng cây sân trường', N'Trồng cây xanh quanh sân trường', CAST(N'2025-05-05T00:00:00.000' AS DateTime), CAST(N'2025-05-07T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-31T01:22:55.907' AS DateTime), 2, N'Tháng 1', N'Sáng', N'Lớp', 2, N'7h30 đến 8h30', CAST(N'2025-01-05' AS Date), N'Tòa A', NULL, 50, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (3, N'Dợt 3 - Vệ sinh khuôn viên', N'Vệ sinh khu vực nhà xe, sân', CAST(N'2025-05-08T00:00:00.000' AS DateTime), CAST(N'2025-05-09T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-31T01:22:46.560' AS DateTime), 3, N'Tháng 2', N'Sáng', N'Lớp', 1, N'7h30 đến 8h30', CAST(N'2025-02-10' AS Date), N'Khu vực nhà hiệu bộ', NULL, 23, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (4, N'Dợt 4 - Thu gom rác khu C', N'Lao động tập thể theo lớp', CAST(N'2025-05-10T00:00:00.000' AS DateTime), CAST(N'2025-05-12T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-29T19:31:28.793' AS DateTime), 1, N'Tháng 2', N'Sáng', N'Cá nhân', 2, N'7h30 đến 8h30', CAST(N'2025-02-10' AS Date), N'Tòa A', NULL, 45, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (5, N'Dợt 5 - Hỗ trợ hội thảo', N'Hỗ trợ tổ chức sự kiện hội thảo khoa học', CAST(N'2025-05-13T00:00:00.000' AS DateTime), CAST(N'2025-05-14T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-29T19:31:40.687' AS DateTime), 2, N'Tháng 3', N'Chiều', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-03-15' AS Date), N'Tòa A', NULL, 34, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (6, N'Dợt 6 - Thu gom rác khu A', N'Lao động tập thể theo lớp', CAST(N'2025-05-15T00:00:00.000' AS DateTime), CAST(N'2025-05-16T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-29T19:32:14.590' AS DateTime), 3, N'Tháng 3', N'Sáng', N'Cá nhân', 2, N'7h30 đến 8h30', CAST(N'2025-03-15' AS Date), N'Tòa C', NULL, 34, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (7, N'Dợt 7 - Trang trí lớp học', N'Trang trí lớp chào mừng ngày lễ', CAST(N'2025-05-17T00:00:00.000' AS DateTime), CAST(N'2025-05-18T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-30T20:29:16.497' AS DateTime), 1, N'Tháng 4', N'Sáng', N'Cá nhân', 2, N'7h30 đến 8h30', CAST(N'2025-04-20' AS Date), N'Tòa A', NULL, 10, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (8, N'Dợt 8 - Hỗ trợ thư viện', N'Sắp xếp tài liệu thư viện', CAST(N'2025-05-19T00:00:00.000' AS DateTime), CAST(N'2025-05-20T00:00:00.000' AS DateTime), CAST(N'2025-05-22T22:29:45.620' AS DateTime), CAST(N'2025-05-30T20:29:47.110' AS DateTime), 2, N'Tháng 4', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-04-20' AS Date), N'Tòa B', NULL, 45, 0)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (11, NULL, N'gh', NULL, NULL, NULL, NULL, NULL, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, N'Tháng 2', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-04-30' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (13, NULL, N'w', NULL, NULL, CAST(N'2025-05-28T23:00:50.713' AS DateTime), CAST(N'2025-05-28T23:00:50.713' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-05-14' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (14, NULL, N'w', NULL, NULL, CAST(N'2025-05-28T23:00:50.683' AS DateTime), CAST(N'2025-05-28T23:00:50.683' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-05-14' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (15, NULL, N'123', NULL, NULL, CAST(N'2025-05-29T00:53:16.117' AS DateTime), CAST(N'2025-05-29T00:53:16.117' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-18' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (16, NULL, N'sadas', NULL, NULL, CAST(N'2025-05-29T00:53:50.310' AS DateTime), CAST(N'2025-05-29T00:53:50.310' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-05' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (17, NULL, N'sadas', NULL, NULL, CAST(N'2025-05-29T00:53:50.387' AS DateTime), CAST(N'2025-05-29T00:53:50.387' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-05' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (18, NULL, N'dssdass', NULL, NULL, CAST(N'2025-05-29T01:05:15.397' AS DateTime), CAST(N'2025-05-29T01:05:15.397' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-06' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (19, NULL, N'12', NULL, NULL, CAST(N'2025-05-29T01:11:11.403' AS DateTime), CAST(N'2025-05-29T01:11:11.403' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (20, NULL, N'12', NULL, NULL, CAST(N'2025-05-29T01:11:24.883' AS DateTime), CAST(N'2025-05-29T01:11:24.883' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (21, NULL, N'ty', NULL, NULL, CAST(N'2025-05-29T01:17:56.003' AS DateTime), CAST(N'2025-05-29T01:17:56.003' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 2, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (25, NULL, N'KLIU', NULL, NULL, CAST(N'2025-05-29T18:18:48.180' AS DateTime), CAST(N'2025-05-29T18:18:48.180' AS DateTime), 1, N'Tháng 2', N'Chiều', N'Cá nhân', 3, N'7h30 đến 8h30', CAST(N'2025-02-07' AS Date), N'Tòa B', NULL, NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (26, NULL, N'KLIU', NULL, NULL, CAST(N'2025-05-29T18:19:01.720' AS DateTime), CAST(N'2025-05-29T18:19:01.720' AS DateTime), 1, N'Tháng 2', N'Chiều', N'Cá nhân', 3, N'7h30 đến 8h30', CAST(N'2025-02-07' AS Date), N'Tòa B', CAST(N'2025-05-29T18:19:07.687' AS DateTime), NULL, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (27, NULL, N'Tập Trung tại khu vực Lao Động', NULL, NULL, CAST(N'2025-05-31T10:53:52.450' AS DateTime), CAST(N'2025-05-31T10:55:30.910' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 2, N'7h30 đến 8h30', CAST(N'2025-01-06' AS Date), N'Tòa A', CAST(N'2025-05-31T11:26:09.607' AS DateTime), 40, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (28, NULL, N'j', NULL, NULL, CAST(N'2025-05-31T11:26:32.040' AS DateTime), CAST(N'2025-05-31T11:26:32.040' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', CAST(N'2025-05-31T11:26:50.273' AS DateTime), 12, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (29, NULL, N'd', NULL, NULL, CAST(N'2025-05-31T11:33:15.597' AS DateTime), CAST(N'2025-05-31T11:33:15.597' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 12, N'7h30 đến 8h30', CAST(N'2025-01-02' AS Date), N'Tòa A', CAST(N'2025-05-31T11:33:20.913' AS DateTime), 12, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (30, NULL, N'1', NULL, NULL, CAST(N'2025-05-31T11:33:41.663' AS DateTime), CAST(N'2025-05-31T11:33:41.663' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 12, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', CAST(N'2025-05-31T11:34:14.193' AS DateTime), 12, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (31, NULL, N'12', NULL, NULL, CAST(N'2025-05-31T11:51:37.553' AS DateTime), CAST(N'2025-05-31T11:51:37.553' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 12, N'7h30 đến 8h30', CAST(N'2025-01-09' AS Date), N'Tòa A', CAST(N'2025-05-31T11:52:34.660' AS DateTime), 21, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (32, NULL, N'1', NULL, NULL, CAST(N'2025-05-31T11:55:36.583' AS DateTime), CAST(N'2025-05-31T11:55:36.583' AS DateTime), 1, N'Tháng 1', N'Chiều', N'Cá nhân', 2, N'7h30 đến 8h30', CAST(N'2025-01-03' AS Date), N'Tòa A', CAST(N'2025-05-31T11:59:06.847' AS DateTime), 12, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (33, NULL, N'lk', NULL, NULL, CAST(N'2025-05-31T11:58:49.180' AS DateTime), CAST(N'2025-05-31T11:58:49.180' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 12, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', CAST(N'2025-05-31T11:59:00.413' AS DateTime), 45, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (34, NULL, N'lk', NULL, NULL, CAST(N'2025-05-31T12:17:11.713' AS DateTime), CAST(N'2025-05-31T12:17:11.713' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-01' AS Date), N'Tòa A', CAST(N'2025-05-31T12:17:53.430' AS DateTime), 3, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (35, NULL, N'fg', NULL, NULL, CAST(N'2025-05-31T12:36:53.897' AS DateTime), CAST(N'2025-05-31T12:36:53.897' AS DateTime), 1, N'Tháng 1', N'Sáng', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-01-02' AS Date), N'Tòa A', NULL, 12, NULL)
INSERT [dbo].[TaoDotNgayLaoDong] ([ID], [TenDotLaoDong], [MoTa], [NgayBatDau], [NgayKetThuc], [NgayTao], [NgayCapNhat], [NguoiTao], [DotLaoDong], [Buoi], [LoaiLaoDong], [GiaTri], [ThoiGian], [NgayLaoDong], [KhuVuc], [Ngayxoa], [SoLuongSinhVien], [TrangThaiDuyet]) VALUES (36, NULL, N'lop', NULL, NULL, CAST(N'2025-05-31T12:42:01.877' AS DateTime), CAST(N'2025-05-31T12:42:01.877' AS DateTime), 1, N'Tháng 2', N'Chiều', N'Cá nhân', 1, N'7h30 đến 8h30', CAST(N'2025-02-07' AS Date), N'Tòa B', NULL, 1, NULL)
SET IDENTITY_INSERT [dbo].[TaoDotNgayLaoDong] OFF
GO
SET IDENTITY_INSERT [dbo].[VaiTro] ON 

INSERT [dbo].[VaiTro] ([vaitro_id], [vaitro]) VALUES (1, N'Admin')
INSERT [dbo].[VaiTro] ([vaitro_id], [vaitro]) VALUES (2, N'QuanLy')
INSERT [dbo].[VaiTro] ([vaitro_id], [vaitro]) VALUES (3, N'SinhVien')
INSERT [dbo].[VaiTro] ([vaitro_id], [vaitro]) VALUES (4, N'LopTruong')
SET IDENTITY_INSERT [dbo].[VaiTro] OFF
GO
ALTER TABLE [dbo].[DanhSachDiemDanh]  WITH CHECK ADD  CONSTRAINT [fk_diemdanh_dot] FOREIGN KEY([dot_id])
REFERENCES [dbo].[TaoDotNgayLaoDong] ([ID])
GO
ALTER TABLE [dbo].[DanhSachDiemDanh] CHECK CONSTRAINT [fk_diemdanh_dot]
GO
ALTER TABLE [dbo].[DanhSachDiemDanh]  WITH CHECK ADD  CONSTRAINT [fk_diemdanh_sv] FOREIGN KEY([MSSV])
REFERENCES [dbo].[SinhVien] ([MSSV])
GO
ALTER TABLE [dbo].[DanhSachDiemDanh] CHECK CONSTRAINT [fk_diemdanh_sv]
GO
ALTER TABLE [dbo].[Lop]  WITH CHECK ADD  CONSTRAINT [fk_khoa] FOREIGN KEY([khoa_id])
REFERENCES [dbo].[Khoa] ([khoa_id])
GO
ALTER TABLE [dbo].[Lop] CHECK CONSTRAINT [fk_khoa]
GO
ALTER TABLE [dbo].[PhieuDangKy]  WITH CHECK ADD  CONSTRAINT [fk_phieudk_dotlaodong] FOREIGN KEY([DotLaoDongId])
REFERENCES [dbo].[TaoDotNgayLaoDong] ([ID])
GO
ALTER TABLE [dbo].[PhieuDangKy] CHECK CONSTRAINT [fk_phieudk_dotlaodong]
GO
ALTER TABLE [dbo].[PhieuDangKy]  WITH CHECK ADD  CONSTRAINT [fk_phieudk_sv] FOREIGN KEY([MSSV])
REFERENCES [dbo].[SinhVien] ([MSSV])
GO
ALTER TABLE [dbo].[PhieuDangKy] CHECK CONSTRAINT [fk_phieudk_sv]
GO
ALTER TABLE [dbo].[PhieuDuyet]  WITH CHECK ADD  CONSTRAINT [fk_duyet_phieu] FOREIGN KEY([PhieuDangKy])
REFERENCES [dbo].[PhieuDangKy] ([id])
GO
ALTER TABLE [dbo].[PhieuDuyet] CHECK CONSTRAINT [fk_duyet_phieu]
GO
ALTER TABLE [dbo].[PhieuDuyet]  WITH CHECK ADD  CONSTRAINT [fk_duyet_quanly] FOREIGN KEY([Nguoiduyet])
REFERENCES [dbo].[QuanLy] ([quanly_id])
GO
ALTER TABLE [dbo].[PhieuDuyet] CHECK CONSTRAINT [fk_duyet_quanly]
GO
ALTER TABLE [dbo].[PhieuXacNhanHoanThanh]  WITH CHECK ADD  CONSTRAINT [fk_xn_duyet] FOREIGN KEY([phieuduyet])
REFERENCES [dbo].[PhieuDuyet] ([id])
GO
ALTER TABLE [dbo].[PhieuXacNhanHoanThanh] CHECK CONSTRAINT [fk_xn_duyet]
GO
ALTER TABLE [dbo].[PhieuXacNhanHoanThanh]  WITH CHECK ADD  CONSTRAINT [fk_xn_quanly] FOREIGN KEY([NguoiXacNhan])
REFERENCES [dbo].[QuanLy] ([quanly_id])
GO
ALTER TABLE [dbo].[PhieuXacNhanHoanThanh] CHECK CONSTRAINT [fk_xn_quanly]
GO
ALTER TABLE [dbo].[PhieuXacNhanHoanThanh]  WITH CHECK ADD  CONSTRAINT [fk_xn_sv] FOREIGN KEY([MSSV])
REFERENCES [dbo].[SinhVien] ([MSSV])
GO
ALTER TABLE [dbo].[PhieuXacNhanHoanThanh] CHECK CONSTRAINT [fk_xn_sv]
GO
ALTER TABLE [dbo].[QuanLy]  WITH CHECK ADD  CONSTRAINT [fk_quanly_taikhoan] FOREIGN KEY([taikhoan])
REFERENCES [dbo].[TaiKhoan] ([taikhoan_id])
GO
ALTER TABLE [dbo].[QuanLy] CHECK CONSTRAINT [fk_quanly_taikhoan]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [fk_anh] FOREIGN KEY([anh_id])
REFERENCES [dbo].[Anh] ([anh_id])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [fk_anh]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [fk_lop] FOREIGN KEY([lop_id])
REFERENCES [dbo].[Lop] ([lop_id])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [fk_lop]
GO
ALTER TABLE [dbo].[SinhVien]  WITH CHECK ADD  CONSTRAINT [fk_taikhoan] FOREIGN KEY([taikhoan])
REFERENCES [dbo].[TaiKhoan] ([taikhoan_id])
GO
ALTER TABLE [dbo].[SinhVien] CHECK CONSTRAINT [fk_taikhoan]
GO
ALTER TABLE [dbo].[SoNgayLaoDong]  WITH CHECK ADD  CONSTRAINT [fk_songay_phieu] FOREIGN KEY([Ma_phieu_xac_nhan])
REFERENCES [dbo].[PhieuXacNhanHoanThanh] ([id])
GO
ALTER TABLE [dbo].[SoNgayLaoDong] CHECK CONSTRAINT [fk_songay_phieu]
GO
ALTER TABLE [dbo].[SoNgayLaoDong]  WITH CHECK ADD  CONSTRAINT [fk_songay_sv] FOREIGN KEY([MSSV])
REFERENCES [dbo].[SinhVien] ([MSSV])
GO
ALTER TABLE [dbo].[SoNgayLaoDong] CHECK CONSTRAINT [fk_songay_sv]
GO
ALTER TABLE [dbo].[TaiKhoan]  WITH CHECK ADD  CONSTRAINT [fk_taikhoan_role] FOREIGN KEY([role_id])
REFERENCES [dbo].[VaiTro] ([vaitro_id])
GO
ALTER TABLE [dbo].[TaiKhoan] CHECK CONSTRAINT [fk_taikhoan_role]
GO
ALTER TABLE [dbo].[TaoDotNgayLaoDong]  WITH CHECK ADD  CONSTRAINT [fk_dot_ngaylaodong_taikhoan] FOREIGN KEY([NguoiTao])
REFERENCES [dbo].[TaiKhoan] ([taikhoan_id])
GO
ALTER TABLE [dbo].[TaoDotNgayLaoDong] CHECK CONSTRAINT [fk_dot_ngaylaodong_taikhoan]
GO
USE [master]
GO
ALTER DATABASE [DB_QLNLD4ROLE] SET  READ_WRITE 
GO
ALTER TABLE PhieuDangKy ADD DotId INT NULL;

ALTER TABLE PhieuDangKy ADD CONSTRAINT fk_phieudk_dot FOREIGN KEY (DotId) REFERENCES TaoDotNgayLaoDong(ID);



-- 1. Xoá ràng buộc FK hiện tại
ALTER TABLE PhieuXacNhanHoanThanh DROP CONSTRAINT fk_xn_duyet;

-- 2. Sửa cột phieuduyet cho phép NULL
ALTER TABLE PhieuXacNhanHoanThanh ALTER COLUMN phieuduyet INT NULL;

-- 3. Thêm lại khóa ngoại, lần này cho phép NULL
ALTER TABLE PhieuXacNhanHoanThanh 
ADD CONSTRAINT fk_xn_duyet 
FOREIGN KEY(phieuduyet) REFERENCES PhieuDuyet(id);