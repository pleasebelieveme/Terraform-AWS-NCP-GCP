# Google Cloud Platform에 액세스하는 Provider 설정
provider "google" {
    # GCP 서비스 계정 키 파일의 경로
    credentials = file("<키이름>")
    # GCP 프로젝트 ID, 지역, 존 설정
    project     = "<프로젝트 ID>"
    region      = "us-central1"
    zone        = "us-central1-a"
}

# GCP에서 사용할 네트워크 생성
resource "google_compute_network" "vpc_network" {
    # 네트워크의 이름 설정
    name = "terraform-network"
}

# GCP에서 가상 머신을 생성하는 리소스 설정
resource "google_compute_instance" "vm_instance" {
    # 가상 머신의 이름 설정
    name         = "terraform-instance"
    # 가상 머신의 크기 및 성능 설정
    machine_type = "f1-micro"

    # 가상 머신의 부팅 디스크 설정
    boot_disk {
        initialize_params {
            # Debian 11 이미지를 사용하여 부팅 디스크 초기화
            image = "debian-cloud/debian-11"
        }
    }

    # 가상 머신이 속할 네트워크 설정
    network_interface {
        # 생성한 네트워크의 이름을 사용하여 연결
        network = google_compute_network.vpc_network.name
        # 공인 IP 주소 설정 (access_config 블록은 비어있음)
        access_config {
        }
    }
}
